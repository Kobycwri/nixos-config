{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quadra = {
      url = "github:QuadraHQ/quadra";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; }; # enables flake inputs to modules
      modules = [ 
        ./hosts/nixos 
        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager
      ];
    };

    homeConfigurations."main@nixos" = home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = { inputs = inputs; };
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        ./home/nixos.nix
      ];
    };
  };
}
