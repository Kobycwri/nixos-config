# Host-specific user configuration for home-manager.
#
# Imported from the flake (homeConfigurations."main@nixos") so the same module
# can be applied both by the system activation (home-manager.users.main) and
# standalone (e.g. nix profile or nix build) if desired.
{ ... }:
{
  imports = [
    ../../home/common.nix
    ../../home/programs/sway.nix
  ];
}
