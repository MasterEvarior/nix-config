# ❄️ NixOS Configuration
[![Nix](https://img.shields.io/badge/built%20with-Nix-5277C3.svg?style=flat-square&logo=NixOS&logoColor=white)](https://nixos.org)  ![Deadnix Workflow](https://github.com/MasterEvarior/nix-config/actions/workflows/dead-code.yaml/badge.svg)  
This is my NixOS configuration, with some help of my personal Nix guru  [Imatpot](https://github.com/imatpot/dotfiles).

## How to use
This guide is strictly for me only. If you try to use it on you machine it will most likely fail, because you do not have the same hardware as I do. So use with caution. 

1 Clone this repository onto your machine  
2. Cd into the appropriate host directory  
3. (Optional) Update the flake with `nix flake update`  
4. Rebuild with `sudo nixos-rebuild --flake . switch`  
5. ❄️❄️❄️ Bathe in the glory of NixOS ❄️❄️❄️  

## Manuel Steps
After the installation a couple of manual steps are still necessary. They are as follows:
- Log into 1Password
- Set passwords with `passwd <user>` where necessary 
- Log into Mozzila account for Firefox
- Log into Jetbrains account for IDEs

## Theme
I try to style everything according to the [Catpuccin Mocha Theme](https://github.com/catppuccin). If you like what you see, head over there and drop them a couple of bucks!

## Development

### Git Hooks
There are some hooks for formatting and the like. To use those, execute the following command:
```shell
git config --local core.hooksPath .githooks/
``` 

### TODOs
- Fixup the 1Password configuration, which is currently split into a [HM module](./homeManagerModules/applications/1password) and a [system module](./nixosModules/1Password/).