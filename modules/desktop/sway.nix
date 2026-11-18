# modules/desktop/sway.nix
{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    sway foot fuzzel swaybg swayidle swaylock
    grim slurp wl-clipboard playerctl
    wiremix android-tools librewolf
    wl-gammarelay-rs wayfreeze
    sway-contrib.grimshot
    inputs.quadra.packages.${pkgs.stdenv.hostPlatform.system}.quadra
    catppuccin-cursors.macchiatoMauve
  ];
}
