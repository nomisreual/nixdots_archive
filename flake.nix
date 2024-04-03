{
  description = "My NixOS config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    #home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # NixVim
    #nixvim.url = "github:nix-community/nixvim";
    #nixvim.inputs.nixpkgs.follows = "nixpkgs";

    # PopOS Cosmic DE Testing
    #nixos-cosmic = {
    #  url = "github:lilyinstarlight/nixos-cosmic";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-cosmic,
    ...
  }@inputs:
    let
      inherit (self) outputs;
    in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
          nixos = nixpkgs.lib.nixosSystem {
          # > main nixos configuration file <
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
	    #{
            #  nix.settings = {
            #    substituters = [ "https://cosmic.cachix.org/" ];
            #    trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            #  };
            #}
            #nixos-cosmic.nixosModules.default
            ./nixos/configuration.nix
          ];
        };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "simon@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        # > Our main home-manager configuration file <
        extraSpecialArgs = {
          inherit inputs outputs;
        };
        modules = [./home-manager/home.nix];
      };
    };
  };
}
