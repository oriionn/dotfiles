{
    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
        withUWSM = false;
    };

    environment.sessionVariables = {
        NIXOS_OZONE_WL = "1"; # hint electron apps to use wayland
        QT_QPA_PLATFORMTHEME = "kde";
    };
}
