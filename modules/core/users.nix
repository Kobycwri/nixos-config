# modules/core/users.nix
{ pkgs, ... }:
{
  users.users."main" = {
    isNormalUser = true;
    description = "main";
    extraGroups = [ "wheel" ];
  };
}
