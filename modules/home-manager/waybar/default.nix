{ lib, ... }:

{
    programs.waybar = {
        enable = true;
        settings = {
            layer = "top";
            position = "top";

            height = 30;
            spacing = 4;

            modules-left = ["hyprland/workspaces"];
            modules-center = ["clock" "custom/separator-media" "custom/media"];
            modules-right = ["pulseaudio#volume" "custom/notifications" "custom/separator" "tray"];

            "hyprland/workspaces" = {
                format = "{icon}";
                # 1: 1, 2: 2,... 11: 1, 12: 2...
                format-icons = lib.genAttrs (map toString (lib.range 1 30))
                    (n: toString (lib.mod (lib.toInt n - 1) 10 + 1));

                show-empty = false;
            };

            tray = {
                icon-size = 18;
                spacing = 10;
            };

            clock = {
                format = "{:L%A %d %B %Y - %H:%M}";
                timezone = "Europe/Paris";
                locale = "fr_FR.utf8";
                tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            };

            "pulseaudio#volume" = {
                format = "<span size='11000'>{icon}</span>";
                format-muted = "<span size='11100'></span>";
                format-icons = {
                    default = ["" "" ""];
                };
                on-click = "pavucontrol";
            };

            "custom/media" = {
                format = "{icon} {text}";
                format-icons = {
                    spotify = "<span size='11000'></span>";
                    firefox = "<span size='11000'>󰈹</span>";
                    default = "<span size='11000'></span>";
                };

                return-type = "json";
                max-length = 40;
                escape = true;

                exec = "playerctl metadata --format '{ \"text\": \"{{ title }} • {{ artist }}\", \"alt\": \"{{ playerName }}\" }' 2> /dev/null";
                exec-if = "which playerctl";
                on-click = "playerctl play-pause";

                tooltip = true;
                tooltip-format = "{text}";
                interval = 1;
            };

            "custom/notifications" = {
                format = "";
                on-click = "swaync-client --toggle-panel";
                tooltip = false;
            };

            "custom/separator" = {
                format = "|";
                interval = "once";
                tooltip = false;
            };
        };

        style = builtins.readFile "${./style.css}";
    };
}
