{ unstable, ... }:

{
    wayland.windowManager.hyprland = {
        enable = true;

        systemd.enable = true;

        package = unstable.hyprland;
        portalPackage = unstable.xdg-desktop-portal-hyprland;

        xwayland.enable = true;

        configType = "lua";

        extraConfig = ''
        --------------------------------
        -- VARIABLES
        --------------------------------

        local mod = "SUPER"
        local terminal = "ghostty"
        local fileManager = "dolphin"
        local menu = "vicinae open"


        --------------------------------
        -- AUTOSTART
        --------------------------------

        hl.on("hyprland.start", function()
            hl.exec_cmd("waybar")
            hl.exec_cmd("udiskie")
            hl.exec_cmd("systemctl --user start hyprpolkitagent")
            hl.exec_cmd("swaync")
            hl.exec_cmd("hyperidle")
            hl.exec_cmd("kdeconnect-indicator")
            hl.exec_cmd("vesktop")
        end)


        --------------------------------
        -- INPUT
        --------------------------------

        hl.config({
            input = {
                kb_layout = "fr",
                kb_variant = "",
                kb_model = "",
                kb_options = "",
                kb_rules = "",

                numlock_by_default = true,

                accel_profile = "flat",
                follow_mouse = 1,
                force_no_accel = 1,
                sensitivity = 0.0,

                touchpad = {
                    natural_scroll = false,
                },
            },

            decoration = {
                rounding = 12,
                rounding_power = 2.0,

                active_opacity = 1.0,
                inactive_opacity = 1.0,

                shadow = {
                    enabled = true,
                    range = 4,
                    render_power = 3,
                    color = "rgba(1a1a1aee)",
                },

                blur = {
                    enabled = true,
                    size = 3,
                    passes = 1,
                    vibrancy = 0.1696,
                },
            },
        })


        --------------------------------
        -- APPLICATIONS
        --------------------------------

        -- Terminal
        hl.bind(
            mod .. " + Q",
            hl.dsp.exec_cmd(terminal)
        )

        -- Kill current window
        hl.bind(
            mod .. " + C",
            hl.dsp.window.close()
        )

        -- Power menu
        hl.bind(
            mod .. " + M",
            hl.dsp.exec_cmd("nwg-bar")
        )

        -- Shutdown
        hl.bind(
            mod .. " + SHIFT + ALT_L",
            hl.dsp.exec_cmd("shutdown now")
        )

        -- File manager
        hl.bind(
            mod .. " + E",
            hl.dsp.exec_cmd(fileManager)
        )

        -- Toggle floating
        hl.bind(
            mod .. " + F",
            hl.dsp.window.float({
            action = "toggle"
            })
        )

        -- Clipboard history
        hl.bind(
            mod .. " + V",
            hl.dsp.exec_cmd(
            "vicinae vicinae://launch/clipboard/history"
            )
        )

        -- App launcher
        hl.bind(
            "ALT + code:65",
            hl.dsp.exec_cmd(menu)
        )

        -- Screenshot
        hl.bind(
            mod .. " + SHIFT + S",
            hl.dsp.exec_cmd(
                "hyprquickshot"
            )
        )

        -- Color picker
        hl.bind(
            mod .. " + SHIFT + C",
            hl.dsp.exec_cmd(
                "hyprpicker -a"
            )
        )

        -- Emoji picker
        hl.bind(
            mod .. " + code:59",
            hl.dsp.exec_cmd(
                "vicinae vicinae://launch/core/search-emojis"
            )
        )

        -- Calculator
        hl.bind(
            "XF86Calculator",
            hl.dsp.exec_cmd(
                "vicinae vicinae://launch/calculator/history"
            )
        )

        -- Lock session
        hl.bind(
            mod .. " + L",
            hl.dsp.exec_cmd(
                "loginctl lock-session"
            )
        )


        --------------------------------
        -- FOCUS
        --------------------------------

        hl.bind(
            mod .. " + left",
            hl.dsp.focus({
                direction = "left"
            })
        )

        hl.bind(
            mod .. " + right",
            hl.dsp.focus({
                direction = "right"
            })
        )

        hl.bind(
            mod .. " + up",
            hl.dsp.focus({
                direction = "up"
            })
        )

        hl.bind(
            mod .. " + down",
            hl.dsp.focus({
                direction = "down"
            })
        )


        --------------------------------
        -- WORKSPACES
        --------------------------------

        -- Numpad:
        --
        -- KP_End    = 1
        -- KP_Down   = 2
        -- KP_Next   = 3
        -- KP_Left   = 4
        -- KP_Begin  = 5
        -- KP_Right  = 6
        -- KP_Home   = 7
        -- KP_Up     = 8
        -- KP_Prior  = 9
        -- KP_Insert = 0 / workspace 10

        local workspaceKeys = {
            { "KP_End",    "ampersand" },
            { "KP_Down",   "eacute" },
            { "KP_Next",   "quotedbl" },
            { "KP_Left",   "apostrophe" },
            { "KP_Begin",  "parenleft" },
            { "KP_Right",  "minus" },
            { "KP_Home",   "egrave" },
            { "KP_Up",     "underscore" },
            { "KP_Prior",  "ccedilla" },
            { "KP_Insert", "agrave" },
        }

        for i, keys in ipairs(workspaceKeys) do
            for _, key in ipairs(keys) do

                -- SUPER + key
                -- Change de workspace
                hl.bind(
                    mod .. " + " .. key,
                    hl.dsp.focus({
                        workspace = i
                    })
                )

                -- SUPER + SHIFT + key
                -- Déplace la fenêtre vers le workspace
                hl.bind(
                    mod .. " + SHIFT + " .. key,
                    hl.dsp.window.move({
                        workspace = i
                    })
                )

            end
        end


        --------------------------------
        -- WORKSPACE SCROLL
        --------------------------------

        hl.bind(
            mod .. " + mouse_down",
            hl.dsp.focus({
            workspace = "e+1"
            })
        )

        hl.bind(
            mod .. " + mouse_up",
            hl.dsp.focus({
            workspace = "e-1"
            })
        )


        --------------------------------
        -- MOUSE
        --------------------------------

        -- SUPER + clic gauche = déplacer fenêtre
        hl.bind(
            mod .. " + mouse:272",
            hl.dsp.window.drag(),
            {
            mouse = true
            }
        )

        -- SUPER + clic droit = resize fenêtre
        hl.bind(
            mod .. " + mouse:273",
            hl.dsp.window.resize(),
            {
            mouse = true
            }
        )


        --------------------------------
        -- VOLUME
        --------------------------------

        hl.bind(
            "XF86AudioRaiseVolume",
            hl.dsp.exec_cmd(
            "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
            ),
            {
            locked = true,
            repeating = true
            }
        )

        hl.bind(
            "XF86AudioLowerVolume",
            hl.dsp.exec_cmd(
            "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            ),
            {
            locked = true,
            repeating = true
            }
        )

        hl.bind(
            "XF86AudioMute",
            hl.dsp.exec_cmd(
            "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ),
            {
            locked = true,
            repeating = true
            }
        )

        hl.bind(
            "XF86AudioMicMute",
            hl.dsp.exec_cmd(
            "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
            ),
            {
            locked = true,
            repeating = true
            }
        )


        --------------------------------
        -- BRIGHTNESS
        --------------------------------

        hl.bind(
            "XF86MonBrightnessUp",
            hl.dsp.exec_cmd(
            "brightnessctl -e4 -n2 set 5%+"
            ),
            {
            locked = true,
            repeating = true
            }
        )

        hl.bind(
            "XF86MonBrightnessDown",
            hl.dsp.exec_cmd(
            "brightnessctl -e4 -n2 set 5%-"
            ),
            {
            locked = true,
            repeating = true
            }
        )


        --------------------------------
        -- MEDIA
        --------------------------------

        hl.bind(
            "XF86AudioNext",
            hl.dsp.exec_cmd(
            "playerctl next"
            ),
            {
            locked = true
            }
        )

        hl.bind(
            "XF86AudioPause",
            hl.dsp.exec_cmd(
            "playerctl play-pause"
            ),
            {
            locked = true
            }
        )

        hl.bind(
            "XF86AudioPlay",
            hl.dsp.exec_cmd(
            "playerctl play-pause"
            ),
            {
            locked = true
            }
        )

        hl.bind(
            "XF86AudioPrev",
            hl.dsp.exec_cmd(
            "playerctl previous"
            ),
            {
            locked = true
            }
        )


        --------------------------------
        -- WINDOW RULES
        --------------------------------

        -- Ignore maximize requests
        hl.window_rule({
            name = "suppress-maximize-events",

            match = {
            class = ".*"
            },

            suppress_event = "maximize",
        })


        -- Fix XWayland dragging
        hl.window_rule({
            name = "fix-xwayland-drags",

            match = {
            class = "^$",
            title = "^$",
            xwayland = true,
            float = true,
            fullscreen = false,
            pin = false,
            },

            no_focus = true,
        })


        -- Clipse
        hl.window_rule({
            name = "clipse",

            match = {
            class = "clipse-gui"
            },

            float = true,
            size = { 622, 652 },
            stay_focused = true,
        })


        -- GNOME Clocks
        hl.window_rule({
            name = "gnome-clocks",

            match = {
            class = "org.gnome.clocks"
            },

            float = true,
            pin = true,
            size = { 600, 450 },
        })


        -- Wakfu
        hl.window_rule({
            name = "wakfu-fullscreen",

            match = {
            class = "com-ankamagames-wakfu-client-WakfuClient"
            },

            fullscreen = true,
        })


        -- Balatro
        hl.window_rule({
            name = "balatro-fullscreen",

            match = {
            class = "steam_app_2379780"
            },

            fullscreen = true,
        })

        --------------------------------
        -- MONITORS
        --------------------------------
        hl.monitor({
            output = "eDP-1",
            mode = "preferred",
            position = "auto",
            scale = 1.175,
        })
        '';
    };

    xdg.configFile."hypr/xdph.conf".source = ./xdph.conf;
}
