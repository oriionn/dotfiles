{ unstable, ... }:

{
    programs.hyprland = {
        enable = true;

        package = unstable.hyprland;
        portalPackage = unstable.xdg-desktop-portal-hyprland;

        xwayland.enable = true;
        withUWSM = false;
    };

    environment.sessionVariables = {
        NIXOS_OZONE_WL = "1"; # hint electron apps to use wayland
        QT_QPA_PLATFORMTHEME = "kde";
    };


    xdg.configFile."kdeglobals".text = ''
      [KDE]
      widgetStyle=Breeze

      [General]
      ColorScheme=BreezeDark
    '';
}
