import re
import sys
from argparse import ArgumentParser
from datetime import date, time

import tomllib

identifier_regex = re.compile(r"[a-zA-Z_][a-zA-Z0-9_'-]*")


def escape_identifier(identifier: str) -> str:
    """Attr Sets may use identifiers or strings for keys, this turns an invalid
    identifier into a string.
    """
    if identifier_regex.match(identifier):
        return identifier
    return f'"{identifier}"'


def nix_value(x, tab: str, parse: bool, depth: int = 1) -> str:
    if isinstance(x, bool):
        return str(x).lower()

    if isinstance(x, (int, float)):
        return str(x)

    if isinstance(x, str):
        if "\n" in x:
            x = x.replace(r"''", r"'''")
            return f"''\n{x}''"

        x = x.replace(r'"', r"\"")
        return f'"{x}"'

    if isinstance(x, list):
        entries = (nix_value(y, tab, depth=depth, parse=parse) for y in x)
        entries = " ".join(entries)
        return f"[ {entries} ]"

    if isinstance(x, dict):
        entries = (
            (
                escape_identifier(key),
                nix_value(value, depth=depth + 1, tab=tab, parse=parse),
            )
            for key, value in x.items()
        )
        entries = (f"{name} = {value};" for name, value in entries)
        sep = "\n" + (tab * depth)
        last_sep = "\n" + (tab * (depth - 1))
        entries = sep.join(entries)
        return f"{{{sep}{entries}{last_sep}}}"

    if isinstance(x, (date, time)):
        if not parse:
            raise ValueError(
                f"{x} is of type {type(x)} which is not representable in nix. "
                "To parse to an equivalent string use the --parse option"
            )
        # There seems to be no way to tell if the source used the T delimiter
        # or a space delimiter (as permitted by RFC 3339 section 5.6) for the
        # sake of readability we use a space. Additionally this clobbers a Z
        # suffix to be +00:00. These are semantically equivalent but a tad
        # ugly.
        return f'"{x}"'

    raise ValueError(
        f"Got {x} which is of type {type(x)}, "
        "according to the python docs this should not happen"
    )


def main():
    parser = ArgumentParser(
        prog="toml2nix",
        description="Convert toml files to nix files",
    )

    parser.add_argument(
        "filename",
        help="The toml file to convert. If '-', read from stdin",
    )

    parser.add_argument(
        "--tab",
        help=r"The string used to represent a tab (default '\t')",
    )

    parser.add_argument(
        "-o",
        "--output",
        help="Where to write output (default stdout)",
    )

    parser.add_argument(
        "-p",
        "--parse",
        action="store_true",
        help="Parse datetimes to strings (default false)",
    )

    args = parser.parse_args()

    tab = args.tab if args.tab is not None else "\t"

    if args.filename == "-":
        input_file = sys.stdin.buffer
    else:
        input_file = open(args.filename, "rb")

    if args.output is None:
        output_file = sys.stdout.buffer
    else:
        output_file = open(args.output, "wb")

    try:
        toml = tomllib.load(input_file)
        output_file.write(nix_value(toml, tab=tab, parse=args.parse).encode())
    except ValueError as e:
        print(e)
        exit(1)
    finally:
        input_file.close()
        output_file.close()


# straight up stolen from here:
# https://github.com/erooke/toml2nix/blob/main/toml2nix
if __name__ == "__main__":
    main()
