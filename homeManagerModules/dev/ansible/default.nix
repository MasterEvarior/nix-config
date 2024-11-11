{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.ansible = {
    enable = lib.mkEnableOption "Ansible";
  };

  config = lib.mkIf config.homeModules.dev.ansible.enable {
    home.packages = with pkgs; [
      ansible
      ansible-lint
      ansible-language-server
    ];

    homeModules.dev.python.enable = true;

    homeModules.applications.vscode.additionalExtensions = with pkgs; [
      vscode-extensions.redhat.ansible
      vscode-extensions.ms-python.python # is needed for the ansible extension
      vscode-extensions.redhat.vscode-yaml # is needed for the ansible extension
    ];
  };
}
