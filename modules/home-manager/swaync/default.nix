{
    services.swaync = {
        enable = true;
        settings = {
            positionX = "right";
            positionY = "top";
            cssPriority = "user";

            layer = "overlay";
            layer-shell = true;

            control-center-layer = "top";
            control-center-margin-top = 13;
            control-center-margin-right = 14;
            control-center-margin-left = 0;
            control-center-width = 800;
            control-center-height = 1000;

            notification-2fa-action = true;
            notification-inline-replies = true;
            notification-icon-size = 48;
            notification-body-image-height = 160;
            notification-body-image-width = 200;
            notification-window-width = 800;

            timeout = 6;
            timeout-low = 3;
            timeout-critical = 0;

            fit-to-screen = false;
            keyboard-shortcuts = true;
            image-visibility = "when-available";
            transition-time = 200;

            hide-on-clear = false;
            hide-on-action = true;
            script-fail-notify = true;

            widgets = [
                "dnd"
                "title"
                "notifications"
            ];

            widget-config = {
                title = {
                    text = "Notifications";
                    clear-all-buttons = true;
                    button-text = "";
                };

                dnd = { text = "Ne pas déranger"; };

                label = {
                    max-lines = 1;
                    text = "Notification";
                };
            };
        };

        style = builtins.readFile "${./style.css}";
    };
}
