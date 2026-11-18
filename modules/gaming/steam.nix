# modules/gaming/steam.nix
{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    extraPackages = with pkgs; [ catppuccin-cursors.macchiatoMauve ];
  };
}
