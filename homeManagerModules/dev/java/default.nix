{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.java = {
    enable = lib.mkEnableOption "Java";
    mavenPackage = lib.mkPackageOption pkgs "maven" { };
    gradlePackage = lib.mkPackageOption pkgs "gradle" { };
  };

  config =
    let
      cfg = config.homeModules.dev.java;
    in
    lib.mkIf config.homeModules.dev.java.enable {
      home.packages = with pkgs; [
        jetbrains.idea-ultimate

        # Maven
        cfg.mavenPackage

        # Gradle
        cfg.gradlePackage
        gradle-completion
      ];

      home.shellAliases =
        let
          mavenBin = lib.getExe cfg.mavenPackage;
        in
        {
          mcv = "${mavenBin} clean verify";
          mct = "${mavenBin} clean test";
          mcp = "${mavenBin} clean package";
          mci = "${mavenBin} clean install";
        };

      programs.java = {
        package = pkgs.jdk23;
        enable = true;
      };
    };
}
