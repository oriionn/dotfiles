{ config, pkgs, ... }:

let
    firefoxWrapper = pkgs.writeShellScript "firefox-wrapper" ''
        if [[ "''${XDG_CURRENT_DESKTOP:-}" == *Hyprland* ]]; then
            profile="hyprland"
        else
            profile="kde"
        fi

        exec firefox \
            --profile "${config.xdg.configHome}/mozilla/firefox/$profile" \
            "$@"
    '';
in
{
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
        exec = "${firefoxWrapper} --name firefox %U";
        settings = {
            StartupWMClass = "firefox";
            Version = "1.5";
        };
        actions = {
            new-private-window = {
                name = "New Private Window";
                exec = "${firefoxWrapper} --private-window %U";
            };
            new-window = {
                name = "New Window";
                exec = "${firefoxWrapper} --new-window %U";
            };
            profile-manager-window = {
                name = "Profile Manager";
                exec = "firefox --ProfileManager";
            };
        };
    };
}
