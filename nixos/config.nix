{ config, pkgs, ... }:

{
    imports =
     [
         ./desktop/hyprland.nix
         ./desktop/kde.nix
         <home-manager/nixos>
     ];

    # Enable unfree packages
    nixpkgs.config.allowUnfree = true;

    # Packages
    environment.systemPackages = with pkgs; [
        git
        neovim

        vlc
        ghostty

        # Fonts
        nerd-fonts.jetbrains-mono
    ];

    # Ly
    services.displayManager.ly.enable = true;

    # Git configuration
    programs.git = {
        enable = true;
        config = {
            user = {
                name = "Orion";
                email = "contact@oriondev.fr";
            };
        };
    };

    # Users
    home-manager.users.orion = import ./home.nix;
}
