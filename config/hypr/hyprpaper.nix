{ ... }:

let
  unstable = import (builtins.fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz"
  ) {};
in
{
    wayland.systemd.target = "hyprland-session.target";

    services.hyprpaper = {
        enable = true;
        package = unstable.hyprpaper;

        systemdTarget = "hyprland-session.target";

        settings = {
            wallpaper = [
                {
                    monitor = "DP-3";
                    path = "~/.dotfiles/assets/wallpapers/screen1.jpg";
                }
                {
                    monitor = "HDMI-A-1";
                    path = "~/.dotfiles/assets/wallpapers/screen2.png";
                }
                {
                    monitor = "eDP-1";
                    path = "~/.dotfiles/assets/wallpapers/screen1.jpg";
                }
            ];
        };
    };
}
