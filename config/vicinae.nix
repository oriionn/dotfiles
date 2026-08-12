{ pkgs, vicinae-extensions, ... }:

{
    programs.vicinae = {
        enable = true;
        systemd = {
            enable = true;
            autoStart = true;
            environment = {
                USE_LAYER_SHELL = 1;
            };
        };

        settings = {
            close_on_focus_loss = true;
            pop_to_root_on_close = true;
            favicon_service = "twenty";

            theme = {
                dark = {
                    name = "kanagawa";
                    icon_theme = "default";
                };
            };

            launcher_window = {
                opacity = 0.98;
            };

            extensions = with vicinae-extensions; [
                 bluetooth
                 wifi-commander
                 mullvad
                 firefox

                 kde-system-settings
                 hypr
                 nix
              ];
        };
    };
}
