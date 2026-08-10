{ config, pkgs, ... }:

{
    imports =
     [
         ./hyprland.nix
         ./kde.nix
         ../config/ghostty/config.nix
     ];

    # Enable unfree packages
    nixpkgs.config.allowUnfree = true;

    # Packages
    environment.systemPackages = with pkgs; [
        git
        neovim

        vlc
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
}
