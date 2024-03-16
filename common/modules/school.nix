{pkgs, ... }: 

{
  environment.systemPackages = with pkgs; [
    pkgs.onedrive
  ];
}