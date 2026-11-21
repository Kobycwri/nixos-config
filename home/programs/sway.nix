# Sway: declarative home-manager configuration, migrated from the
# non-declarative ~/.config/sway setup (default sway config + customizations).
{ config, pkgs, lib, ... }:
{
  # Sway session dependencies used in key bindings below.
  # Declared via home.packages so they live in the home profile (kept even if
  # sway itself is later disabled); pinned by their store paths in the
  # generated sway config.
  home.packages = with pkgs; [
    foot wofi broot
    grim slurp grimshot grimblast
    swaylock swaybg swayidle
    wl-clipboard playerctl brightnessctl
    pactl yazi nvim librewolf
  ];

  programs.sway = {
    enable = true;
    xwayland.enable = true;

    # Modifier: $mod = Mod4 (Super/Win key), the default.
    modifier = "Mod4";

    # Workspaces / gaps
    workspaceBackAndForth = true;
    gaps = {
      inner = 4;
      outer = 4;
    };

    # Key bindings (structured options cover the default sway config bindings)
    menu = "${pkgs.wofi}/bin/wofi --show-drun";
    terminal = "${pkgs.foot}/bin/foot";
    editor = "${pkgs.nvim}/bin/nvim";
    files = "${pkgs.yazi}/bin/yazi";
    browser = "${pkgs.librewolf}/bin/librewolf";
    music = "${pkgs.playerctl}/bin/playerctl play-pause";

    # Extra raw sway config: font, idle hook, and media/volume/brightness
    # bindings that are not covered by the structured options.
    config = ''
      ### Font
      font pango:Inter 10

      ### Idle configuration
      exec swayidle -w \
        timeout 300 'swaylock -f -c catppuccin' \
        timeout 600 'swaymsg "output * power off"' \
        resume 'swaymsg "output * power on"' \
        before-sleep 'swaylock -f -c catppuccin'

      ### Volume / brightness / media
      bindsym XF86AudioRaiseVolume exec ${pkgs.pactl}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%
      bindsym XF86AudioLowerVolume exec ${pkgs.pactl}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%
      bindsym XF86AudioMute exec ${pkgs.pactl}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle
      bindsym XF86MonBrightnessUp exec ${pkgs.brightnessctl}/bin/brightnessctl set 10%+
      bindsym XF86MonBrightnessDown exec ${pkgs.brightnessctl}/bin/brightnessctl set 10%-
      bindsym XF86AudioPlay exec ${pkgs.playerctl}/bin/playerctl play
      bindsym XF86AudioPause exec ${pkgs.playerctl}/bin/playerctl pause
      bindsym XF86AudioNext exec ${pkgs.playerctl}/bin/playerctl next
      bindsym XF86AudioPrev exec ${pkgs.playerctl}/bin/playerctl previous
      bindsym XF86AudioStop exec ${pkgs.playerctl}/bin/playerctl stop

      # Wallpaper
      # exec_always swaybg -i /path/to/wallpaper.jpg
    '';
  };
}
