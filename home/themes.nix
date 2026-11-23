# home/themes.nix
{ inputs, pkgs, ... }:
{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "mocha";
    accent = "mauve";
    cursors.enable = true;
    gtk.icon.enable = true;
    swaylock.enable = true;
    foot.enable = true;
    btop.enable = true;
  };

  programs = {
    btop = {
      enable = true;
      package = pkgs.btop-cuda;
    };
    foot.enable = true;
  };

  gtk.enable = true;

  home.pointerCursor = {
    enable = true;
    size = 24;
    sway.enable = true;
    gtk.enable = true;
    x11.enable = true;
  };
}
