{ pkgs, ... }:

{
  # Many scripts are pretty much copied from this blog post, check it out it's good
  # https://evanhahn.com/scripts-i-wrote-that-i-use-all-the-time/
  home.packages = [
    (import ./tempe.nix { inherit pkgs; })
    (import ./mkcd.nix { inherit pkgs; })
    (import ./rn.nix { inherit pkgs; })
    (import ./dsdestroy.nix { inherit pkgs; })
  ];
}
