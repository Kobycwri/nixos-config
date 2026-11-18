# hosts/nixos/default.nix
{ lib, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../../modules/core
    ../../modules/hardware
    ../../modules/desktop
    ../../modules/gaming
    ../../modules/services
  ];

  system.stateVersion = "26.05";
}
