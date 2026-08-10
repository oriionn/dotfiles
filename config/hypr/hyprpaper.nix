{ ... }:

let
  unstable = import (builtins.fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz"
  ) {};
in
{
    services.hyprpaper = {
      enable = true;
      package = unstable.hyprpaper;

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
        ];
      };
    };
}
