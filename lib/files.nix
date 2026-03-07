{ lib }:
rec {
  from = d: lib.filterAttrs (_: v: v == "regular") (builtins.readDir d);
  withType = d: t: builtins.filter (f: lib.hasSuffix t f) (builtins.attrNames (from d));
  toHomeManagerFile =
    {
      files,
      sourcePath,
      targetPath,
      executable ? false,
    }:
    builtins.listToAttrs (
      map (f: rec {
        name = "${targetPath}/${f}";
        value = {
          inherit executable;
          target = name;
          text = builtins.readFile (sourcePath + "/${f}");
        };
      }) files
    );
}
