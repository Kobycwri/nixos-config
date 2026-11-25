{ pkgs, ... }:
{
  programs = {
    btop = {
      enable = true;
      package = pkgs.btop-cuda;
    };
    foot.enable = true;
    fuzzel.enable = true;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  home.pointerCursor.sway.enable = true;
}
