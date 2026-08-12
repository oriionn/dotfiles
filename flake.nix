{
	description = "A very basic flake";

	nixConfig = {
	    extra-substituters = [ "https://vicinae.cachix.org" ];
		extra-trusted-public-keys = [ "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc=" ];
	}

	inputs = {
  		nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
  		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

  		home-manager = {
 			url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        hyprquickshot-source = {
            url = "github:jamdon2/hyprquickshot";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        vicinae.url = "github:vicinaehq/vicinae";
	};

  	outputs = {self, nixpkgs, nixpkgs-unstable, home-manager, hyprquickshot-source, vicinae}:
  	let
		system = "x86_64-linux";

		pkgs = nixpkgs.legacyPackages.${system};
		unstable = nixpkgs-unstable.legacyPackages.${system};
		hyprquickshot-unfixed = hyprquickshot-source.packages.${system}.default;

		# Fix Hyprquickshot
		hyprquickshot = pkgs.writeShellScriptBin "hyprquickshot" ''
            export QT_QPA_PLATFORMTHEME=
            exec ${hyprquickshot-unfixed}/bin/hyprquickshot "$@"
        '';
	in
	{
		nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
			inherit system;
			specialArgs = { inherit unstable; inherit hyprquickshot; };
			modules = [
                ./nixos/hardware/laptop.nix
                ./nixos/config.nix

                home-manager.nixosModules.home-manager
                vicinae.nixosModules.default

                {
                    home-manager.sharedModules = [ vicinae.homeManagerModules.default ];
                }
            ];
		};
	};
}
