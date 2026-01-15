{
  lib,
  config,
  pkgs,
  pkgs-unstable,
  ...
}:

{
  options.homeModules.dev.java = {
    enable = lib.mkEnableOption "Java";
    javaPackage = lib.mkPackageOption pkgs "jdk25" { };
    mavenPackage = lib.mkPackageOption pkgs "maven" { };
    gradlePackage = lib.mkPackageOption pkgs "gradle" { };
  };

  config =
    let
      cfg = config.homeModules.dev.java;
    in
    lib.mkIf config.homeModules.dev.java.enable {
      home.packages =
        with pkgs;
        [
          # Maven
          cfg.mavenPackage

          # Gradle
          cfg.gradlePackage
          gradle-completion

          # Quarkus
          quarkus
        ]
        ++ [
          pkgs-unstable.jetbrains.idea
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
        package = cfg.javaPackage;
        enable = true;
      };
    };
}
