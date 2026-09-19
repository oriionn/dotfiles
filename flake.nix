{
    description = "My NixOS configuration";

    nixConfig = {
	    extra-substituters = [ "https://vicinae.cachix.org" ];
		extra-trusted-public-keys = [ "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc=" ];
	};

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
 			url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        hyprsplit = {
            url = "github:shezdy/hyprsplit";
            flake = false;
        };

        hyprquickshot = {
            url = "github:jamdon2/hyprquickshot";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nix-index-database = {
            url = "github:nix-community/nix-index-database";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        phoenix.url = "git+https://git.oriondev.fr/orion/phoenix.git";
        downtime.url = "git+https://git.oriondev.fr/orion/downtime.git";
        ofetch.url = "git+https://git.oriondev.fr/orion/ofetch.git";
        # waybar.url = "github:Alexays/Waybar";
        nix-flatpak.url = "github:gmodena/nix-flatpak";
        vicinae.url = "github:vicinaehq/vicinae";
        pyroclear.url = "github:shreyanth-sureshkrishnaa/pyroclear";
    };

    outputs = inputs: let
    	system = "x86_64-linux";

        pkgs = inputs.nixpkgs.legacyPackages.${system};
        hyprquickshot = pkgs.writeShellScriptBin "hyprquickshot" ''
            export QT_QPA_PLATFORMTHEME=
            exec ${inputs.hyprquickshot.packages.${system}.default}/bin/hyprquickshot "$@"
        '';
    in {
        nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
                inherit inputs hyprquickshot;
                username = "orion";
                configName = "laptop";
            };

            modules = [
                inputs.home-manager.nixosModules.home-manager
                inputs.vicinae.nixosModules.default
                inputs.nix-flatpak.nixosModules.nix-flatpak

                ({ configName, ... }: {
                    home-manager.extraSpecialArgs = { inherit inputs configName system; };
                })

                {
                    home-manager.sharedModules = [
                        inputs.vicinae.homeManagerModules.default
                        inputs.nix-index-database.homeModules.default
                    ];
                }

                ./hosts/laptop
            ];
        };
    };
}
