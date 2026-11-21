# Sway: declarative home-manager configuration.
#
# Migrated from the non-declarative ~/.config/sway setup (which was just the
# stock sway default config plus a few tweaks). The structured
# `wayland.windowManager.sway.config` options cover the stock sway bindings
# and layout, and anything not expressible (font, idle hook, media/brightness
# keybindings) is added via `wayland.windowManager.sway.extraConfig`.
{ config, pkgs, ... }:
{
  # Sway session dependencies used in key bindings below. Declared via
  # home.packages so they live in the home profile (kept even if sway itself
  # is later disabled); the generated sway config pins their store paths.
  home.packages = with pkgs; [
    foot
    wofi
    broot
    grim
    slurp
    grimshot
    grimblast
    swaylock
    swaybg
    swayidle
    wl-clipboard
    playerctl
    brightnessctl
    pactl
    yazi
    nvim
    librewolf
  ];

  # Use the sway package installed by the system (modules/desktop/sway.nix),
  # not the one home-manager would pull into the home profile.
  programs.sway.package = null;

  wayland.windowManager.sway = {
    enable = true;
    xwayland.enable = true;

    config = {
      # Workspaces / gaps
      workspaceAutoBackAndForth = true;
      gaps = {
        inner = 4;
        outer = 4;
      };

      # Key bindings (the structured options cover the stock sway bindings)
      menu = "${pkgs.wofi}/bin/wofi --show-drun";
      terminal = "${pkgs.foot}/bin/foot";
      keybindings."${config.wayland.windowManager.sway.config.modifier}+b" =
        "exec ${pkgs.broot}/bin/broot";
    };

    # Anything not covered by the structured options:
    extraConfig = ''
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
