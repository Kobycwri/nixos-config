# modules/desktop/cursors.nix
#
# Catppuccin (macchiato/mauve) cursor theme, shared by the X session, sway
# (wayland.windowManager.sway.config.seat) and Steam (programs.steam.extraPackages).
{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.catppuccin-cursors.macchiatoMauve ];

  environment.sessionVariables = {
    XCURSOR_THEME = "catppuccin-macchiato-mauve-cursors";
    XCURSOR_SIZE = "24";
  };

  xdg.icons.fallbackCursorThemes = [ "catppuccin-macchiato-mauve-cursors" ];
}
