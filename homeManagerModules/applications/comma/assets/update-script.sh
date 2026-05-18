notify-send "System" "Updating nix-index..."
nix run 'nixpkgs#nix-index' --extra-experimental-features 'nix-command flakes'
notify-send "System" "Finished updating nix-index..."