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
         ./desktop/kde.nix
         ./desktop/hyprland.nix
         (import "${home-manager}/nixos")
     ];

    # Enable NixOS experimental features
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

        # Audio
        playerctl
        pavucontrol

        # Social Media
        vesktop

        # Utilities
        waybar
        udiskie
        vicinae
        swaynotificationcenter
        nwg-bar

        # Hyprland
        unstable.hyprpolkitagent
        unstable.hyprlock
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

    # Fingerprint scanner
    services.fprintd.enable = true;
    security.pam.services.login.rules.auth.fprintd.settings = {
        timeout = 5;
    };
    security.pam.services.hyprlock = {
        fprintAuth = false;
    };

    # Users
    users.users.orion.extraGroups = [ "networkmanager" "wheel" ];
    users.users.orion.packages = with pkgs; [];

    home-manager.users.orion = import ./home.nix;
}
