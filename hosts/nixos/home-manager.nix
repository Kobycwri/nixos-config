# Host: nixos
{ config, ... }:
{
  # Enable per-user home-manager (managed by flake homeConfigurations.)
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.main = import ./home.nix;
}
