# modules/desktop/themes.nix
{ pkgs, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

    cursor = {
      package = pkgs.rose-pine-cursor; # Built into nixpkgs
      name = "BreezeX-RosePine-Linux"; # Dark variant
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        terminal = 11;
        applications = 10;
        popups = 11;
        desktop = 10;
      };
    };
  };

  fonts.packages = with pkgs; [
    noto-fonts-cjk-sans
  ];

  console = {
    font = "Lat2-Terminus16";
    packages = [ pkgs.terminus_font ];
  };
}
