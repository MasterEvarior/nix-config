{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.modules.dev.ansible = {
    enable = lib.mkEnableOption "Ansible module";
  };

  config = lib.mkIf config.modules.dev.ansible.enable {
    environment.systemPackages = with pkgs; [
      python3
      ansible
      ansible-lint
      ansible-language-server
    ];
  };
}
