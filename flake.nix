{
  description = "My NixOS config";

  inputs = {
    # Nixpkgs
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    # home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Stylix
    stylix.url = "github:danth/stylix";

    # NixVim
    nixvim.url = "github:nomisreual/nixvim";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    stylix,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        # > Main nixos configuration file <
        specialArgs = {
          inherit inputs outputs;
        };
        modules = [
          ./nixos/configuration.nix
          stylix.nixosModules.stylix
        ];
      };
    };

    # Standalone home-manager configuration entrypoint Available through 'home-manager --flake .#simon@nixos'
    homeConfigurations = {
      "simon@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        # > Main home-manager configuration file <
        extraSpecialArgs = {
          inherit inputs outputs;
        };
        modules = [./home-manager/home.nix stylix.homeManagerModules.stylix];
      };
    };
  };
}
