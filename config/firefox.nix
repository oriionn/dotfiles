{ ... }:

let
  ffExec = extra: ''sh -c 'if [ "$XDG_CURRENT_DESKTOP" = "Hyprland" ]; then exec firefox --profile "$HOME/.mozilla/firefox/hyprland" ${extra} "$@"; else exec firefox ${extra} "$@"; fi' -- %U'';
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
        exec = ffExec "--name firefox";
        settings = {
            StartupWMClass = "firefox";
            Version = "1.5";
        };
        actions = {
            new-private-window = {
                name = "New Private Window";
                exec = ffExec "--private-window";
            };
            new-window = {
                name = "New Window";
                exec = ffExec "--new-window";
            };
            profile-manager-window = {
                name = "Profile Manager";
                exec = "firefox --ProfileManager";
            };
        };
    };
}
