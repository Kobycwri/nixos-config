# Shared home-manager configuration (all users/hosts)
{ pkgs, inputs, ... }:
{
  # Enable programs and services defined in home-manager modules.
  home.stateVersion = "26.05";

  # Ensure important programs are provided by home-manager rather than the
  # system configuration, so the two cannot drift apart.
  home.packages = [
    (inputs.yapfast.packages.${pkgs.system}.default.overrideAttrs (oldAttrs: {
      # 1. Stop Nixpkgs 26.11 from forcing system AWS-LC
      dontCargoUseSystemLibs = true;

      # 2. Provide CMake so aws-lc-sys can compile its internal copy
      nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [
        pkgs.cmake
      ];
    }))
  ];
}
