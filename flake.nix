{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
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
    nightcap = {
      url = "github:CoderDayton/nightcap";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yapfast = {
      url = "github:yapfast/yapfast";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, sops-nix, chaotic, quadra, llm-agents, stylix, yapfast, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; }; # enables flake inputs to modules
      modules = [
        ./hosts/nixos
        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager
        inputs.stylix.nixosModules.stylix
        inputs.chaotic.nixosModules.default
      ];
    };

    homeConfigurations."main@nixos" = home-manager.lib.homeManagerConfiguration {
      specialArgs = { inputs = inputs; };
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        ./home/nixos.nix
      ];
    };
  };
}
