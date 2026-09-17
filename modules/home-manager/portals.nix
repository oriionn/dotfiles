{ pkgs, ... }:

{
    # XDG Portals
    xdg.portal = {
        enable = true;

        extraPortals = with pkgs; [
            xdg-desktop-portal-gtk
            kdePackages.xdg-desktop-portal-kde
        ];

        config = {
            common.default = [ "gtk" ];

            kde = {
                default = [ "kde" "gtk" ];
                "org.freedesktop.impl.portal.OpenURI" = "gtk";
            };

            hyprland = {
                default = [ "hyprland" "gtk" ];
                "org.freedesktop.impl.portal.OpenURI" = "gtk";
                "org.freedesktop.portal.ScreenCast" = "kde";
                "org.freedesktop.portal.RecordScreen" = "kde";
            };
        };
    };

    # Default apps
    xdg.mimeApps = {
        enable = true;
        defaultApplications = {
            "x-scheme-handler/http" = "firefox.desktop";
            "x-scheme-handler/https" = "firefox.desktop";
        };
    };
    xdg.configFile."mimeapps.list".force = true;
}
