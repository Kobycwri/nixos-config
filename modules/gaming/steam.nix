{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    # Steam bundles its own cursor theme; keep the catppuccin one available
    # in-session via XCURSOR_THEME (set in modules/desktop/cursors.nix).
    extraPackages = [ pkgs.catppuccin-cursors.macchiatoMauve ];
  };
}
