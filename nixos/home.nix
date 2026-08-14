{ config, unstable, pkgs, ... }:

{
    imports = [
        ../config/ghostty/config.nix
        ../config/nwg-bar/bar.nix
        ../config/hypr/hyprland.nix
        ../config/hypr/hyprpaper.nix
        ../config/hypr/hypridle.nix
        ../config/hypr/hyprlock.nix
        ../config/hyfetch.nix
        ../config/vicinae.nix
        ../config/zsh.nix
    ];

    xdg.configFile."fastfetch" = {
        source = ../config/fastfetch;
        recursive = true;
    };

    xdg.configFile."waybar" = {
        source = ../config/waybar;
        recursive = true;
    };

    xdg.configFile."swaync" = {
        source = ../config/swaync;
        recursive = true;
    };

    # XDG Portals
    xdg.portal = {
        enable = true;

        extraPortals = [
            pkgs.xdg-desktop-portal-gtk
            pkgs.kdePackages.xdg-desktop-portal-kde
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

    # Firefox profile depending DE
    programs.firefox = {
        enable = true;
        languagePacks = ["fr-FR" "en-GB"];

        profiles.kde = {
            id = 0;
            isDefault = true;
        };
        profiles.hyprland = {
            id = 1;
        };
    };

    xdg.desktopEntries.firefox = {
        name = "Firefox";
        genericName = "Web Browser";
        type = "Application";
        icon = "firefox";
        terminal = false;
        startupNotify = true;
        categories = [ "Network" "WebBrowser" ];
        mimeType = [
            "text/html"
            "text/xml"
            "application/xhtml+xml"
            "application/vnd.mozilla.xul+xml"
            "x-scheme-handler/http"
            "x-scheme-handler/https"
        ];

        exec = ''
            sh -c '
                if [ "$XDG_CURRENT_DESKTOP" = "Hyprland" ]; then
                    exec firefox --name firefox --profile "$HOME/.mozilla/firefox/hyprland" "$@";
                else
                    exec firefox --name firefox "$@";
                fi
            ' -- %U
        '';

        settings = {
            StartupWMClass = "firefox";
            Version = "1.5";
        };
        actions = {
            new-private-window = {
                name = "New Private Window";
                exec = ''
                    sh -c '
                        if [ "$XDG_CURRENT_DESKTOP" = "Hyprland" ]; then
                            exec firefox --profile "$HOME/.mozilla/firefox/hyprland" --private-window "$@";
                        else
                            exec firefox --private-window "$@";
                        fi
                    ' -- %U
                '';
            };
            new-window = {
                name = "New Window";
                exec = ''
                    sh -c '
                        if [ "$XDG_CURRENT_DESKTOP" = "Hyprland" ]; then
                            exec firefox --profile "$HOME/.mozilla/firefox/hyprland" --new-window "$@";
                        else
                            exec firefox --new-window "$@";
                        fi
                    ' -- %U
                '';
            };
            profile-manager-window = {
                name = "Profile Manager";
                exec = "firefox --ProfileManager";
            };
        };
    };

    # Home Manager version
    home.stateVersion = "26.05";
}
