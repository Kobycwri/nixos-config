# Enable per-user home-manager on this host.
#
# `users.main` receives the exact same module as the flake's
# homeConfigurations."main@nixos" entry (home/nixos.nix), so the
# system-managed activation and a standalone `nix build .#homeConfigurations
# ...` always produce identical results.
{ ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  # On activation, move pre-existing (non-HM) files to a .bak copy instead
  # of aborting the whole activation when a managed path is occupied.
  home-manager.backupFileExtension = "bak";
  home-manager.users.main = import ../../home/nixos.nix;
}
