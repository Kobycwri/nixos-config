# modules/desktop/themes.nix
{ pkgs, ... }:
{
  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono noto-fonts noto-fonts-cjk-sans noto-fonts-color-emoji ];

  console = {
    font = "Lat2-Terminus16";
    packages = [ pkgs.terminus_font ];
  };

  environment.sessionVariables = {
    XCURSOR_THEME = "catppuccin-macchiato-mauve-cursors";
    XCURSOR_SIZE = "24";
  };

  xdg.icons.fallbackCursorThemes = [ "catppuccin-macchiato-mauve-cursors" ];
}
