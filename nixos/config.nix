{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz";

  unstable = import (builtins.fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz"
  ) {};
in
{
    imports =
     [
         ./desktop/hyprland.nix
         ./desktop/kde.nix
         (import "${home-manager}/nixos")
     ];

    # Enable unfree packages
    nixpkgs.config.allowUnfree = true;

    # Packages
    environment.systemPackages = with pkgs; [
        # Terminal
        ghostty
        git
        neovim
        fastfetch

        # Multimedia
        vlc
        firefox

        # Social Media
        vesktop

        # Utilities
        waybar
        udiskie
        vicinae
        swaynotificationcenter

        # Hyprland
        unstable.hyprpolkitagent
        unstable.hypridle

        # Fonts
        nerd-fonts.jetbrains-mono
    ];

    # Ly
    services.displayManager.ly = {
        enable = true;
        x11Support = false;

        settings = {
            xsessions = null;
            shell = false;
        };
    };

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
    users.users.orion.extraGroups = [ "networkmanager" "wheel" ];
    users.users.orion.packages = with pkgs; [];

    home-manager.users.orion = import ./home.nix;
}
