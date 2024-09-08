{
  description = "calista flake config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nvim-config = {
      url = "git+file:./host/neovim/nvim";
      flake = false;
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nvim-config,
    ...
  } @ inputs: let
    overlays = [inputs.neovim-nightly-overlay.overlays.default];
    lib = nixpkgs.lib;
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [./configuration.nix];
      };
    };
    homeConfigurations = {
      calista = home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs {
          system = "x86_64-linux";
          config = {
            allowUnfree = true;
          };
        };
        extraSpecialArgs = {inherit nvim-config;};
        modules = [
          ./home.nix
          {
            nixpkgs.overlays = overlays;
          }
        ];
      };
    };
  };
}
