# modules/core/nix.nix
{ pkgs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Leave empty for now; wire this up via sops-nix later.
  # nix.settings.access-tokens = [ "github.com=${config.sops.secrets.github_token.path}" ];
}
