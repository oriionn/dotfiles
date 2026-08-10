{ ... }:

let
  unstable = import (builtins.fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz"
  ) {};
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

        plugins = [
            unstable.hyprlandPlugins.hyprsplit
        ];
     };
}
