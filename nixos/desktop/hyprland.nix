{ ... }:

{
    programs.hyprland.enable = true;
    environment.sessionVariables.NIXOS_OZONE_WL = "1"; # hint electron apps to use wayland
}
