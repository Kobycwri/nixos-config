{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wget
    git
    htop
    btop-cuda
    fastfetch
    nvtopPackages.nvidia
  ];
}
