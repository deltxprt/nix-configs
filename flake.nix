{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hydenix = {
      # Available inputs:
      # Main: github:richen604/hydenix
      # Commit: github:richen604/hydenix/<commit-hash>
      # Version: github:richen604/hydenix/v1.0.0 - note the version may not be compatible with this template
      url = "github:richen604/hydenix";

      # uncomment the below if you know what you're doing, hydenix updates nixos-unstable every week or so
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home manager
#    home-manager.url = "github:nix-community/home-manager/release-25.05";
#    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
      { ... }@inputs:
      let
        system = "x86_64-linux";
        hydenixConfig = inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./nixos/hydenix/configuration.nix
          ];
        };

      in
      {
        nixosConfigurations.hydenix = hydenixConfig;
        nixosConfigurations.default = hydenixConfig;
      };

#  outputs = {
#    self,
#    nixpkgs,
#    home-manager,
#    ...
#  } @ inputs: let
#    inherit (self) outputs;
#  in {
#    # NixOS configuration entrypoint
#    # Available through 'nixos-rebuild --flake .#your-hostname'
#    nixosConfigurations = {
#      desktop = nixpkgs.lib.nixosSystem {
#        specialArgs = {inherit inputs outputs;};
#        system = "x86_64-linux";
#        modules = [
#          ./nixos/configuration.nix
#        ];
#      };
#      dev = nixpkgs.lib.nixosSystem {
#        specialArgs = {inherit inputs outputs;};
#        system = "x86_64-linux"; 
#        modules = [./nixos/dev/configuration.nix];
#      };
#      laptop = nixpkgs.lib.nixosSystem {
#        specialArgs = {inherit inputs outputs;};
#        system = "x86_64-linux"; 
#        modules = [
#          ./nixos/configuration-laptop.nix
#        ];
#      };
#
#    };
#
#    # Standalone home-manager configuration entrypoint
#    # Available through 'home-manager --flake .#your-username@your-hostname'
#    homeConfigurations = {
#      "delta@desktop" = home-manager.lib.homeManagerConfiguration {
#        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
#        extraSpecialArgs = {inherit inputs outputs;};
#        # > Our main home-manager configuration file <
#        modules = [./home-manager/desktop/home.nix];
#      };
#      "delta@dev" = home-manager.lib.homeManagerConfiguration {
#        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
#        extraSpecialArgs = {inherit inputs outputs;};
#        # > Our main home-manager configuration file <
#        modules = [./home-manager/dev/home.nix];
#      };
#      "delta@laptop" = home-manager.lib.homeManagerConfiguration {
#        pkgs = nixpkgs.legacyPackages.x86_64-linux;
#        extraSpecialArgs = {inherit inputs outputs;};
#        modules = [./home-manager/laptop/home.nix];
#      };
#    };
#  };
}
