{
 description = "calista flake config";

 inputs = {
  nixpkgs.url = "nixpkgs/nixos-24.05";
  home-manager.url = "github:nix-community/home-manager/release-24.05";
  home-manager.inputs.nixpkgs.follows = "nixpkgs";
  hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
 };

 outputs = { self, nixpkgs, home-manager, ... } @inputs:
  let 
   lib = nixpkgs.lib;
   system = "x86_64-linux";
   pkgs = nixpkgs.legacyPackages.${system};
  in {
  nixosConfigurations = {
	nixos = lib.nixosSystem {
	 inherit system;
 	 specialArgs = { inherit inputs; };
	 modules = [ ./configuration.nix ];
	};
  };
  homeConfigurations = {
	calista = home-manager.lib.homeManagerConfiguration  {
	 inherit pkgs;
	 modules = [ ./home.nix ];
	};
  };
 };
}
