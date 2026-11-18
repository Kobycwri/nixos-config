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
  systemd.network.networks."10-enp34s0" = {
    matchConfig.Name = "enp34s0";
    address = [ "192.168.0.136/22" ];
    routes = [ { Gateway = "192.168.0.1"; } ];
    networkConfig = {
      DNS = [
        "192.168.0.40"
        "192.168.0.41"
        "fdf9:6341:caa2::40"
        "fdf9:6341:caa2::41"
      ];
      IPv6AcceptRA = true;
    };
  };
}
