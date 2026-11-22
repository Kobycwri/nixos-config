# home/themes.nix
{ inputs, pkgs, lib, ... }:

let
  # Replace Mocha's washed-out backgrounds (#1e1e2e / #181825 / #11111b)
  # Use "000000" for pure black, or "11111b" if you want to keep a faint dark-blue tint
  darkMocha = {
    mocha = {
      base = "13131e";
      mantle = "0e0e17";
      crust = "090910";
    };
  };
in
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

  home.pointerCursor = {
    enable = true;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
