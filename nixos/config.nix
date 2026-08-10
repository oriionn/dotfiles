{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz;
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
    users.users.orion.extraGroups = [ "networkmanager" "wheel" ];
    users.users.orion.packages = with pkgs; [];

    home-manager.users.orion = import ./home.nix;
}
