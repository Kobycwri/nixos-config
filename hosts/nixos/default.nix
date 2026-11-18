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
  ] ++ lib.optionals (builtins.pathExists .local.nix) [ ./local.nix ];

  system.stateVersion = "26.05";
}
