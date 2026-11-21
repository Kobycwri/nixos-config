{ pkgs, inputs, ... }:
{
  imports = [
    ./steam.nix
  ];
  
  environment.systemPackages = with pkgs; [
    prismlauncher
    inputs.quadra.packages.${pkgs.stdenv.hostPlatform.system}.quadra
  ];

  programs.gpu-screen-recorder.enable = true;
  programs.gamemode.enable = true;
}
