{ ... }:

let
  unstable = import (builtins.fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz"
  ) {};
in
{
    imports = [
        ../config/ghostty/config.nix
        ../config/hypr/hyprland.nix
        ../config/hypr/hyprpaper.nix
    ];

    home.stateVersion = "26.05";

    # Hyprsplit
    wayland.windowManager.hyprland = {
        enable = true;

        plugins = [
            unstable.hyprlandPlugins.hyprsplit
        ];
     };
}
