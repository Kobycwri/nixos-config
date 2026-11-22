{ pkgs, inputs, ... }:
{
  imports = [
    ./steam.nix
    ./autoclicker.nix
  ];
  
  environment.systemPackages = with pkgs; [
    prismlauncher
    inputs.quadra.packages.${pkgs.stdenv.hostPlatform.system}.quadra
    inputs.nightcap.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.gpu-screen-recorder.enable = true;
  programs.gamemode.enable = true;
}
