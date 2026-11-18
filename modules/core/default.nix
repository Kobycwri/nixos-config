# modules/core/default.nix
{ ... }:
{
  imports = [
    ./boot.nix
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./users.nix
    ./packages.nix
    ./secrets.nix
  ];
}
