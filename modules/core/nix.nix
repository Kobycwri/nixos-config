# modules/core/nix.nix
{ pkgs, ... }:
{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    extra-substituters = [ "https://cache.numtide.com" ];
    extra-trusted-public-keys = [
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    ];
  };
  nixpkgs.config.allowUnfree = true;
  hardware.enableRedistributableFirmware = true;
  # Leave empty for now; wire this up via sops-nix later.
  # nix.settings.access-tokens = [ "github.com=${config.sops.secrets.github_token.path}" ];
}
