# Host-specific user configuration for home-manager.
#
# Imported from the flake (homeConfigurations."main@nixos") so the same module
# can be applied both by the system activation (home-manager.users.main) and
# standalone (e.g. nix profile or nix build) if desired.
{ inputs, ... }:
{
  imports = [
    ./common.nix
    ./themes.nix
    ./programs/sway.nix
    ./programs/notification.nix
    ./programs/coding.nix
  ];
}
