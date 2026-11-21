# Sway: declarative home-manager configuration.
#
# Migrated from the non-declarative ~/.config/sway setup (which was the stock
# sway default config plus a few tweaks). The structured
# `wayland.windowManager.sway.config` options cover the stock sway bindings
# and layout; anything not expressible (font, idle hook, wl-gammarelay
# brightness/temperature controls, screenshot scripts, cursor theme) is added
# via `wayland.windowManager.sway.extraConfig`.
{ config, pkgs, ... }:
{
  # Sway session dependencies used in key bindings below. Declared via
  # home.packages so they live in the home profile (kept even if sway itself
  # is later disabled); the generated sway config pins their store paths.
  home.packages = with pkgs; [
    foot
    fuzzel
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
    wl-gammarelay-rs
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
      menu = "fuzzel";
      terminal = "foot";
      keybindings."${config.wayland.windowManager.sway.config.modifier}+b" =
        "exec ${pkgs.broot}/bin/broot";
    };

    # Anything not covered by the structured options:
    extraConfig = ''
      ### Font
      font pango:Inter 10

      ### Cursor
      seat seat0 xcursor_theme catppuccin-macchiato-mauve-cursors 24

      ### Idle configuration
      exec swayidle -w \
        timeout 300 'swaylock -f -c catppuccin' \
        timeout 600 'swaymsg "output * power off"' \
        resume 'swaymsg "output * power on"' \
        before-sleep 'swaylock -f -c catppuccin'

      # Color management (wl-gammarelay-rs)
      exec wl-gammarelay-rs

      ### Volume / media (wpctl, part of wireplumber)
      bindsym --locked XF86AudioMute exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindsym --locked XF86AudioLowerVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bindsym --locked XF86AudioRaiseVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
      bindsym --locked ${config.wayland.windowManager.sway.config.modifier}+XF86AudioMute exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      bindsym --locked ${config.wayland.windowManager.sway.config.modifier}+XF86AudioLowerVolume exec wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-
      bindsym --locked ${config.wayland.windowManager.sway.config.modifier}+XF86AudioRaiseVolume exec wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+

      # Media keys via playerctl
      bindsym --locked XF86AudioPlay exec ${pkgs.playerctl}/bin/playerctl play-pause
      bindsym --locked XF86AudioPause exec ${pkgs.playerctl}/bin/playerctl play-pause
      bindsym --locked XF86AudioPrev exec ${pkgs.playerctl}/bin/playerctl previous
      bindsym --locked XF86AudioNext exec ${pkgs.playerctl}/bin/playerctl next
      bindsym --locked XF86AudioStop exec ${pkgs.playerctl}/bin/playerctl stop

      ### Screenshots (scripts in ~/.scripts)
      # Region selection (frozen) - press Print
      bindsym --release Print exec $HOME/.scripts/screenshot-region.sh
      # Focused application - press $mod+Print
      bindsym --release ${config.wayland.windowManager.sway.config.modifier}+Print exec $HOME/.scripts/screenshot-window.sh
      # Entire desktop - press Alt+Print
      bindsym --release Alt+Print exec $HOME/.scripts/screenshot-full.sh

      ### Brightness / color temperature (software, via wl-gammarelay-rs)
      # Decrease brightness
      bindsym ${config.wayland.windowManager.sway.config.modifier}+F5 exec busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateBrightness d -0.02
      # Increase brightness
      bindsym ${config.wayland.windowManager.sway.config.modifier}+F6 exec busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateBrightness d +0.02
      # Decrease temperature (warmer/redder)
      bindsym ${config.wayland.windowManager.sway.config.modifier}+Shift+F5 exec busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n -100
      # Increase temperature (cooler/bluer)
      bindsym ${config.wayland.windowManager.sway.config.modifier}+Shift+F6 exec busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n +100

      ### Status bar
      bar {
          position top

          status_command while date +'%Y-%m-%d %X'; do sleep 1; done

          colors {
              statusline #ffffff
              background #323232
              inactive_workspace #32323200 #32323200 #5c5c5c
          }
      }
    '';
  };
}
