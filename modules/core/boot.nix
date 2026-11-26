# modules/core/boot.nix
{ pkgs, ... }:
{
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_cachyos;
    kernel.sysctl = {
      "kernel.sysrq" = 0;
      "net.core.default_qdisc" = "fq";
      "net.ipv4.tcp_congestion_control" = "bbr3";
      "net.ipv4.tcp_mtu_probing" = 1;
    };
  };
}
