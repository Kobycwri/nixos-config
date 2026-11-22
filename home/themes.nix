# home/themes.nix
{ inputs, pkgs, ... }:

{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  # Set your desired flavor globally for all Catppuccin-enabled programs
  catppuccin = {
    flavor = "macchiato"; # or "latte", "frappe", "macchiato"
    accent = "mauve";
    swaylock.enable = true;
    foot.enable = true;
    btop.enable = true;
  };

  # You can enable theming for other programs here too, for example:
  # catppuccin.starship.enable = true;
  # catppuccin.btop.enable = true;

  home.pointerCursor = {
    enable = true;
    package = pkgs.catppuccin-cursors.macchiatoMauve;
    name = "catppuccin-macchiato-mauve-cursors";
    size = 24; # Adjust to your preference
    gtk.enable = true;
    x11.enable = true;
  };
}
