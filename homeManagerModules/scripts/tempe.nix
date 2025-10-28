{
  pkgs,
  ...
}:

pkgs.writeShellApplication {
  name = "tempe";
  text = ''
    cd "$(mktemp -d)"
    chmod -R 0700 .
    if [[ $# -eq 1 ]]; then
      \mkdir -p "$1"
      cd "$1"
      chmod -R 0700 .
    fi
  '';
}
