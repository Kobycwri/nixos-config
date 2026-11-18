# modules/core/networking.nix
{ ... }:
{
  networking.hostName = "nixos";
  networking.networkmanager.enable = false;
  networking.useNetworkd = true;
  networking.useDHCP = false;
  networking.tempAddresses = "enabled";

  services.resolved.enable = true;

  systemd.network.enable = true;
}
