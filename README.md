# ❄️ NixOS Configuration
[![Nix](https://img.shields.io/badge/built%20with-Nix-5277C3.svg?style=flat-square&logo=NixOS&logoColor=white)](https://nixos.org)  
This is my NixOS configuration, which is highly inspired by [Imatpot](https://github.com/imatpot/dotfiles).

## How to use
This guide is strictly for me only. If you try to use it on you machine it will most likely fail, because you do not have the same hardware as I do. So use with caution. 

1. Clone this repository onto your machine
2. [Symlink](https://stackoverflow.com/questions/1240636/symlink-copying-a-directory-hierarchy) the contents of the repo to your `/etc/nixos` directory
3. Replace the content of your `configuration.nix` file with the one of `configuration.template.nix`. Create a backup beforehand, if you are unsure or don't know what you are doing.
4. Replace `{hostname}` with one of the hosts in the `/hosts` directory.
5. Rebuild with `sudo nixos-rebuild switch` 
5. ❄️❄️❄️ Bathe in the glory of NixOS ❄️❄️❄️
