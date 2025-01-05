{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.nix = {
    enable = lib.mkEnableOption "Nix";
  };

  config = lib.mkIf config.homeModules.dev.nix.enable {
    home.packages = with pkgs; [
      nixfmt-rfc-style
      nixd
      deadnix
      nurl
    ];

    home.shellAliases = {
      # Update package cache for comma
      nuc = "nix run 'nixpkgs#nix-index' --extra-experimental-features 'nix-command flakes'";

      # Update a flake
      nuf = "nix flake update";

      # Apply current config
      nrs = "sudo nixos-rebuild --flake . switch";

      # Delete old packages
      ncg = "nix-collect-garbage";
    };

    homeModules.applications.vscode = {
      additionalSnippets = {
        nix = {
          "Create toggleable configuration" = {
            prefix = [ "tog-conf" ];
            description = "Create toggleable .nix configuration";
            body = [
              "{"
              "\tlib,"
              "\tconfig,"
              "\tpkgs,"
              "\t..."
              "}:"
              ""
              "{"
              "\toptions.\${1|modules,homeModules|}.$2 = {"
              "\t\tenable = lib.mkEnableOption \"$3\";"
              "\t};"
              ""
              "\tconfig = lib.mkIf config.$1.$2.enable {"
              "\t};"
              "}"
            ];
          };
          "Create basic configuration" = {
            prefix = [ "conf" ];
            description = "Create basix .nix configuration";
            body = [
              "{"
              "\tpkgs,"
              "\t..."
              "}:"
              ""
              "{"
              "\t$1"
              "}"
            ];
          };
          "Create an option with mkOption" = {
            prefix = [ "mkOption" ];
            description = "Create an option with mkOption";
            body = [
              "lib.mkOption {"
              "\tdefault = $1;"
              "\texample = $2;"
              "\ttype = lib.types.$3;"
              "\tdescription = \"$4\";"
              "};"
            ];
          };
        };
      };

      additionalExtensions = with pkgs; [ vscode-extensions.jnoortheen.nix-ide ];

      additionalUserSettings = {
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              command = [ "nixfmt" ];
            };
          };
        };
        "[nix]" = {
          "editor.formatOnSave" = true;
        };
      };
    };

    homeModules.applications.treefmt.additionalFormatters = with pkgs; [
      {
        name = "deadnix";
        command = "deadnix";
        includes = [ "*.nix" ];
        options = [ "--edit" ];
        package = deadnix;
      }
      {
        name = "nixfmt-rfc-style";
        command = "nixfmt";
        includes = [ "*.nix" ];
        package = nixfmt-rfc-style;
      }
    ];
  };
}
