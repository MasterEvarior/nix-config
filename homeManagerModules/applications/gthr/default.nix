{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.gthr = {
    enable = lib.mkEnableOption "A CLI tool for gathering text context of a directory";
  };

  config =
    let
      gthr = pkgs.rustPlatform.buildRustPackage rec {
        pname = "gthr";
        version = "v0.2.1";

        src = pkgs.fetchFromGitHub {
          owner = "Adarsh-Roy";
          repo = pname;
          rev = version;
          hash = "sha256-X+YUdXDnyArqTuTGwWmxyUAFViSeSrn+L4b6worbzwA=";
        };

        cargoHash = "sha256-mvrj9Ficq+iInlVuWZNvIhrqnunpfm4cOSzF+nBktq4=";
      };
    in

    lib.mkIf config.homeModules.applications.gthr.enable {
      home.packages = [
        gthr
      ];
    };
}
