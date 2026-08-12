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

    # Home Manager version
    home.stateVersion = "26.05";
}
