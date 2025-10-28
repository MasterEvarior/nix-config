{
  pkgs,
  ...
}:

pkgs.writeShellApplication {
  name = "mkcd";
  text = ''
    mkdir -p "$1"
    cd "$1"
  '';
}
