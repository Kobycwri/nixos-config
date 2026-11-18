# modules/hardware/nvidia.nix
{ pkgs, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    nvidiaSettings = true;
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    branch = "latest";
  };
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
