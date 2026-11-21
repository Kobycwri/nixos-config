# Shared home-manager configuration (all users/hosts)
{ pkgs, ... }:
{
  # Enable programs and services defined in home-manager modules.
  home.stateVersion = "26.05";

  # Ensure important programs are provided by home-manager rather than the
  # system configuration, so the two cannot drift apart.
  home.packages = [ ];
}
