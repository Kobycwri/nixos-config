# modules/core/secrets.nix
{ config, pkgs, ... }:
{
  # Point to your encrypted secrets file
  sops.defaultSopsFile = ../../secrets/secrets.yaml;

  # Use the age key you generated for decryption
  sops.age.keyFile = "/home/main/.config/sops/age/keys.txt";

  # Define the specific secret you want to use
  sops.secrets.github_token = {
    owner = "root";
    group = "root";
    mode = "0400";
  };

  # Use a template to securely inject the secret into Nix's configuration
  sops.templates."nix-access-tokens" = {
    content = ''
      access-tokens = github.com=${config.sops.placeholder.github_token}
    '';
    owner = "root";
    group = "root";
    mode = "0440";
  };

  # Tell Nix to read the access token from the generated template file
  nix.extraOptions = ''
    !include ${config.sops.templates."nix-access-tokens".path}
  '';
}
