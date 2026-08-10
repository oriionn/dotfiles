{ config, pkgs, ... }:

{
    imports =
     [
         ./hyprland.nix
     ];

    # Enable unfree packages
    nixpkgs.config.allowUnfree = true;

    # Packages
    environment.systemPackages = with pkgs; [
        git
        neovim
    ];

    # KDE
    services = {
        desktopManager.plasma6.enable = true;
    };

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
