# modules/desktop/sway.nix
#
# System-side Sway session setup. The config file and most session apps
# (foot, fuzzel, broot, wl-clipboard, playerctl, wl-gammarelay-rs, ...) live
# in home-manager (home/programs/sway.nix, which sets
# `wayland.windowManager.sway.package = null`). This module only provides
# what home-manager does not:
#
#   - the wrapped sway binary on the PATH (session wrapper: dbus-run-session,
#     xwayland, GTK env) via programs.sway
#   - sway-session.target (user systemd session integration)
#   - the NixOS sway config drop-in (/etc/sway/config.d/nixos.conf)
#   - xdg-desktop-portal-wlr / -gtk backends (screen sharing, screenshots)
#   - graphical-desktop, xwayland and polkit service plumbing
{ pkgs, inputs, ... }:
{
  # Session plumbing and apps that are only used by the sway session but
  # have no home-manager equivalent (kept system-wide on purpose).
  environment.systemPackages = with pkgs; [
    grim
    slurp
    sway-contrib.grimshot
    grimblast
    swaylock
    swaybg
    swayidle
    wiremix
    inputs.quadra.packages.${pkgs.stdenv.hostPlatform.system}.quadra
  ];

  programs.sway.enable = true;
}
