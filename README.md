# Simple NixOS configuration using Flakes and Home Manager

## Update flake.lock
nix flake update

## Update System
sudo nixos-rebuild switch --flake .#nixos

## Update User
home-manager switch --flake .#simon@nixos
