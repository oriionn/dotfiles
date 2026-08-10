{ ... }:

let
    hyprsplit = builtins.fetchGit {
        url = "https://github.com/shezdy/hyprsplit";
        ref = "main";
    };
in
{
    imports = [
        ../config/ghostty/config.nix
    ];

    home.stateVersion = "26.05";

    # Config files
    xdg.configFile."hypr/hyprland.conf".source = ../config/hypr/hyprland.conf;
    xdg.configFile."hypr/hyprpaper.conf".source = ../config/hypr/hyprpaper.conf;

    # Hyprsplit
    wayland.windowManager.hyprland = {
        enable = true;

        extraLuaFiles = {
            # ~/.config/hypr/hyprsplit/init.lua
            "hyprsplit/init" = {
                autoLoad = false;
                content = builtins.readFile "${hyprsplit}/init.lua";
            };

            # Chargé automatiquement par Hyprland
            "hyprsplit-config" = {
                autoLoad = true;
                content = ''
                    local hs = require("hyprsplit")

                    hs.config({
                        num_workspaces = 10
                    })
                '';
            };
        };
     };
}
