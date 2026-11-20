{ pkgs,  ... }:
{
  imports = [
    ./steam.nix
  ];
  
  environment.systemPackages = with pkgs; [
    prismlauncher
  ];

  programs.gpu-screen-recorder.enable = true;
  programs.gamemode.enable = true;
}
