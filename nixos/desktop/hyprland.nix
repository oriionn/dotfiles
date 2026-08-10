{ ... }:

let
  unstable = import (builtins.fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz"
  ) {};
in
{
    programs.hyprland = {
        enable = true;

        package = unstable.hyprland;
        portalPackage = unstable.xdg-desktop-portal-hyprland;

        xwayland.enable = true;
        withUWSM = false;
    };
    environment.sessionVariables.NIXOS_OZONE_WL = "1"; # hint electron apps to use wayland
}
