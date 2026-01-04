{
  lib,
  config,
  ...
}:

{
  options.modules.settings.cross-compilation = {
    enable = lib.mkEnableOption "Enable cross compilation";
    supportedArchitectures = lib.mkOption {
      default = [ "aarch64-linux" ];
      example = [
        "aarch64-linux"
        "powerpc64-linux"
      ];
      type = lib.types.listOf (
        lib.types.enum [
          "aarch64-linux"
          "aarch64_be-linux"
          "alpha-linux"
          "armv6l-linux"
          "armv7l-linux"
          "i386-linux"
          "i486-linux"
          "i586-linux"
          "i686-linux"
          "i686-windows"
          "loongarch64-linux"
          "mips-linux"
          "mips64-linux"
          "mips64-linuxabin32"
          "mips64el-linux"
          "mips64el-linuxabin32"
          "mipsel-linux"
          "powerpc-linux"
          "powerpc64-linux"
          "powerpc64le-linux"
          "riscv32-linux"
          "riscv64-linux"
          "s390x-linux"
          "sparc-linux"
          "sparc64-linux"
          "wasm32-wasi"
          "wasm64-wasi"
          "x86_64-linux"
          "x86_64-windows"
        ]
      );
      description = "List of systems to emulate. Will also configure Nix to support your new systems. Warning: the builder can execute all emulated systems within the same build, which introduces impurities in the case of cross compilation.";
    };
  };

  config =
    let
      cfg = config.modules.settings.cross-compilation;
    in
    lib.mkIf config.modules.settings.cross-compilation.enable {
      boot.binfmt.emulatedSystems = cfg.supportedArchitectures;
    };
}
