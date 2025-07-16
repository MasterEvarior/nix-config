#!/bin/bash

read -p "This will take a very long time. Are you sure you want to continue? (y/n) " -n 1 -r
echo


if [[ $REPLY =~ ^[Yy]$ ]]
then
  sudo nix-store --repair --verify --check-contents
else
  echo "Operation cancelled by user."
  exit 0
fi