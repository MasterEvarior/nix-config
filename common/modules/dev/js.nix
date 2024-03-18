{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ pkgs.nodejs_21 ];
}
