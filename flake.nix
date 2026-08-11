{
	description = "A very basic flake";

	inputs = {
    		nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    		home-manager = {
    			url = "github:nix-community/home-manager/release-26.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

  	outputs = {self, nixpkgs, nixpkgs-unstable, home-manager}: 
  	let 
		system = "x86_64-linux";
		unstable = nixpkgs-unstable.legacyPackages.${system};
	in 
	{
		nixosConfiguration.computer = nixpkgs.lib.nixosSystem {
			inherit system;
			specialArgs = { inherit unstable; };
			modules = [
				/etc/nixos/hardware-configuration.nix
				./nixos/config.nix
				home-manager.nixosModules.home-manager
			];
		};
	};
}
