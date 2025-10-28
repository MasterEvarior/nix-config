{
  pkgs,
  ...
}:

pkgs.writeShellApplication {
  name = "dsdestroy";
  text = ''
    set -e
    set -u
    set -o pipefail

    find . -name .DS_Store -delete
  '';
}
