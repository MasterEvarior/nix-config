{
  pkgs ? import <nixpkgs> { },
}:

pkgs.stdenv.mkDerivation rec {
  pname = "cz-git";
  name = pname;
  version = "v1.12.0";

  src = pkgs.fetchFromGitHub {
    owner = "Zhengqbbb";
    repo = "cz-git";
    rev = "459d95fe061c9fee75180b2faeb23886f00cc2bf";
    hash = "sha256-8qYZ9Dc35AsfW4k6c0JNap2G9uLBY8Uw/TXqzo9GnoI=";
  };

  nativeBuildInputs = [
    pkgs.nodejs
    pkgs.pnpm.configHook
  ];

  pnpmDeps = pkgs.pnpm.fetchDeps {
    inherit pname version src;
    fetcherVersion = 1;
    hash = "sha256-1ZlUQSLg+x3F32uqA1CqrFLg/MHoR9ARtB1YU6RZgmM=";
  };

  buildPhase = ''
    runHook preBuild

    npm run build

    runHook postBuild
  '';

  installPhase = ''
    cp -R packages $out
  '';
}
