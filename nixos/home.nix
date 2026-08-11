{ unstable, ... }:

{
    imports = [
        ../config/ghostty/config.nix
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

    xdg.configFile."nwg-bar" = {
        source = ../config/nwg-bar;
        recursive = true;
    };

    home.stateVersion = "26.05";
}
