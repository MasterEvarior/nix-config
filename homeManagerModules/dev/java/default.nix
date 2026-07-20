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
    additionalJdkVersions = lib.mkOption {
      default = [ pkgs.jdk21 ];
      example = [ pkgs.jdk21 ];
      type = lib.types.listOf lib.types.package;
      description = "Additional JDKs to install into ~/jdks";
    };
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

          # Additional Java Versions
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

      home.sessionPath = [ "$HOME/.jdks" ];
      home.file = (
        builtins.listToAttrs (
          map (jdk: {
            name = ".jdks/${jdk.version}";
            value = {
              source = jdk;
            };
          }) cfg.additionalJdkVersions
        )
      );
    };
}
