# ❄️ NixOS Configuration

[![Nix](https://img.shields.io/badge/built%20with-Nix-5277C3.svg?style=flat-square&logo=NixOS&logoColor=white)](https://nixos.org) ![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/MasterEvarior/nix-config/quality.yaml?style=flat-square&logo=github&label=Quality%20Check)

This is my NixOS configuration, with some help of my personal Nix guru  [Imatpot](https://github.com/imatpot/dotfiles).

## How to use

### Setup

This guide is strictly for me only. If you try to use it on you machine it will most likely fail, because you do not have the same hardware as I do. So use with caution.

1 Clone this repository onto your machine\
2\. Cd into the appropriate host directory\
3\. (Optional) Update the flake with `nix flake update`\
4\. Rebuild with `sudo nixos-rebuild --flake . switch`\
5\. ❄️❄️❄️ Bathe in the glory of NixOS ❄️❄️❄️

#### Manuel Steps

After the installation a couple of manual steps are still necessary. They are as follows:

- Log into 1Password
- Set passwords with `passwd <user>` where necessary
- Log into Mozzila account for Firefox
- Log into Jetbrains account for IDEs

### Secrets

Secrets are managed with [sops-nix](https://github.com/Mic92/sops-nix) in a separate repository.

### Backups

Backups are done weekly to [Backblaze B2](https://www.backblaze.com/), zipped and encrypted with GPG.

Use this command to decrypt then when necessary:

```shell
gpg --decrypt --pinentry-mode loopback --output test.zip 2025-01-02T193940.zip
```

### Displaylink

If docking station with DisplayLink should be used, it is necessary to include the `displaylink` driver package and set the video driver settings:

```
services.xserver.videoDrivers = [ 
    "displaylink" 
    "modesetting" 
];
```

Alternatively the drivers can be downloaded manually:

```
nix-prefetch-url --name displaylink-600.zip https://www.synaptics.com/sites/default/files/exe_files/2024-05/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu6.0-EXE.zip
```

## Resources

A list of all the PCs/Laptops and their users.

### Users

- `giannin` - My personal user
- `work` - User for work
- `htpc` - User for the home theater PC in the living room

### Hosts

- `arrakis` - My Thinkpad P16s Gen 2
- `caladan`- My Desktop (whatever the specs may be)

## Theming

I try to style everything according to the [Catpuccin Mocha Theme](https://github.com/catppuccin). If you like what you see, head over there and drop them a couple of bucks!

## Development

### Linting

Run all the linters with the `treefmt` command. Note that the command does not install the required formatters.

```shell
treefmt
```

### Git Hooks

There are some hooks for formatting and the like. To use those, execute the following command:

```shell
git config --local core.hooksPath .githooks/
```

### TODOs

- Fixup the 1Password configuration, which is currently split into a [HM module](./homeManagerModules/applications/1password) and a [system module](./nixosModules/1Password/).
