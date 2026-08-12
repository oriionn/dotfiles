{ config, unstable, ... }:

{
    imports = [
        ../config/ghostty/config.nix
        ../config/nwg-bar/bar.nix
        ../config/hypr/hyprland.nix
        ../config/hypr/hyprpaper.nix
        ../config/hypr/hypridle.nix
        ../config/hypr/hyprlock.nix
        ../config/hyfetch.nix
    ];

    xdg.configFile."fastfetch" = {
        source = ../config/fastfetch;
        recursive = true;
    };

    xdg.configFile."waybar" = {
        source = ../config/waybar;
        recursive = true;
    };

    xdg.configFile."swaync" = {
        source = ../config/swaync;
        recursive = true;
    };

    # XDG Directories
    xdg.userDirs = {
        enable = true;
        createDirectories = true;

        desktop = "${config.home.homeDirectory}/Bureau";
        documents = "${config.home.homeDirectory}/Documents";
        download = "${config.home.homeDirectory}/Téléchargements";
        music = "${config.home.homeDirectory}/Musique";
        pictures = "${config.home.homeDirectory}/Images";
        publicShare = "${config.home.homeDirectory}/Public";
        templates = "${config.home.homeDirectory}/Modèles";
        videos = "${config.home.homeDirectory}/Vidéos";

        # Define session variables
        setSessionVariables = true;
    };

    # Home Manager version
    home.stateVersion = "26.05";
}
