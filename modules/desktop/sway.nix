# modules/desktop/sway.nix
#
# System-side Sway session setup. The config file and all session apps live
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
{ ... }:
{
  programs.sway.enable = true;
}
