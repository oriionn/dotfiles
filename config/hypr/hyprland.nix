{ ... }:

let
  unstable = import (builtins.fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz"
  ) {};
in
{
    wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = false;

        package = unstable.hyprland;
        portalPackage = unstable.xdg-desktop-portal-hyprland;
        xwayland.enable = true;

        settings = {
            "$mod" = "SUPER";
            "$terminal" = "ghostty";
            "$fileManager" = "thunar";
            "$menu" = "vicinae open";

            exec-once = [
                "waybar"
                "udiskie"
                "systemctl --user start hyprpolkitagent"
                "vicinae server"
                "swaync"
                "hyperidle"
                "kdeconnect-indicator"
                "vesktop"
            ];

            input = {
                kb_layout = "fr";
                kb_variant = "";
                kb_model = "";
                kb_options = "";
                kb_rules = "";

                numlock_by_default = true;

                accel_profile = "flat";
                follow_mouse = 1;
                force_no_accel = 1;
                sensitivity = 0.0;

                touchpad = {
                  natural_scroll = false;
                };
            };

            bind = [
                # Terminal
                "$mod, Q, exec, $terminal"

                # Kill current window
                "$mod, C, killactive"

                # Power off menu
                "$mod, M, exec, nwg-bar"

                # Shutdown
                "$mod SHIFT, Alt_L, exec, shutdown now"

                # File manager
                "$mod, E, exec, $fileManager"

                # Float window
                "$mod, F, togglefloating"

                # Clipboard history
                "$mod, V, exec, vicinae vicinae://extensions/vicinae/clipboard/history"

                # App launcher
                "Alt_L, code:65, exec, $menu"

                # Screenshot
                "$mod SHIFT, S, exec, quickshell -c hyprquickshot -n"

                # Color picker
                "$mod SHIFT, C, exec, hyprpicker -a"

                # Emoji picker
                "$mod, code:59, exec, vicinae vicinae://extensions/vicinae/vicinae/search-emojis"

                # Calculator
                ", XF86Calculator, exec, vicinae vicinae://extensions/vicinae/calculator/history"

                # Lock session
                "$mod, L, exec, loginctl lock-session"

                # Focus
                "$mod, left, movefocus, l"
                "$mod, right, movefocus, r"
                "$mod, up, movefocus, u"
                "$mod, down, movefocus, d"

                # Workspaces
                "$mod, KP_End, split:workspace, 1"
                "$mod, KP_Down, split:workspace, 2"
                "$mod, KP_Next, split:workspace, 3"
                "$mod, KP_Left, split:workspace, 4"
                "$mod, KP_Begin, split:workspace, 5"
                "$mod, KP_Right, split:workspace, 6"
                "$mod, KP_Home, split:workspace, 7"
                "$mod, KP_Up, split:workspace, 8"
                "$mod, KP_Prior, split:workspace, 9"
                "$mod, KP_Insert, split:workspace, 10"

                # Move window to workspace
                "$mod SHIFT, KP_End, split:movetoworkspace, 1"
                "$mod SHIFT, KP_Down, split:movetoworkspace, 2"
                "$mod SHIFT, KP_Next, split:movetoworkspace, 3"
                "$mod SHIFT, KP_Left, split:movetoworkspace, 4"
                "$mod SHIFT, KP_Begin, split:movetoworkspace, 5"
                "$mod SHIFT, KP_Right, split:movetoworkspace, 6"
                "$mod SHIFT, KP_Home, split:movetoworkspace, 7"
                "$mod SHIFT, KP_Up, split:movetoworkspace, 8"
                "$mod SHIFT, KP_Prior, split:movetoworkspace, 9"
                "$mod SHIFT, KP_Insert, split:movetoworkspace, 10"

                # Scroll through workspaces
                "$mod, mouse_down, workspace, e+1"
                "$mod, mouse_up, workspace, e-1"
            ];

            bindm = [
                "$mod, mouse:272, movewindow"
                "$mod, mouse:273, resizewindow"
            ];

            # Volume + brightness
            bindel = [
                ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
                ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
                ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
                ", XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
                ", XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
            ];

            # Media keys
            bindl = [
                ", XF86AudioNext, exec, playerctl next"
                ", XF86AudioPause, exec, playerctl play-pause"
                ", XF86AudioPlay, exec, playerctl play-pause"
                ", XF86AudioPrev, exec, playerctl previous"
            ];

            window_rule = [
                # Ignore maximize requests from apps
                {
                    match.class = ".*";
                    suppress_event = "maximize";
                }

                # Fix some dragging issues with XWayland
                {
                    match = {
                        class = "^$";
                        title = "^$";
                        xwayland = true;
                        float = true;
                        fullscreen = false;
                        pin = false;
                    };

                    no_focus = true;
                }

                # Clipse
                {
                    match.class = "clipse-gui";

                    float = true;
                    size = [ 622 652 ];
                    stay_focused = true;
                }

                # GNOME Clocks
                {
                    match.class = "org.gnome.clocks";

                    float = true;
                    pin = true;
                    size = [ 600 450 ];
                }

                # Wakfu fullscreen
                {
                    match.class = "com-ankamagames-wakfu-client-WakfuClient";
                    fullscreen = true;
                }

                # Balatro fullscreen
                {
                    match.class = "steam_app_2379780";
                    fullscreen = true;
                }
            ];
        };
    };
}
