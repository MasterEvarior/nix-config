{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ pkgs.node_js21 ];
}
