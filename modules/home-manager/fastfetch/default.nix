{ config, ... }:

{
    xdg.configFile."fastfetch/minimal.jsonc".source = ./minimal.jsonc;

    programs.fastfetch = {
        enable = true;
        settings = {
            logo = {
                width = 35;
                height = 15;
                padding = {
                    top = 1;
                    left = 1;
                };
            };

            display = {
                separator = " ";
                color = {
                    keys = "yellow";
                    title = "yellow";
                };
            };

            modules = [
                "title"
                "break"
                {
                    type = "os";
                    key = "󰣇 ";
                }
                {
                    type = "kernel";
                    key = " ";
                }
                {
                    type = "wm";
                    key = " ";
                }
                {
                    type = "packages";
                    key = " ";
                }
                {
                    type = "shell";
                    key = " ";
                }
                {
                    type = "command";
                    text = "downtime";
                    key = " ";
                }
                {
                    type = "command";
                    text = "phoenix -s fr";
                    key = "󰚭 ";
                }
                "break"
                {
                    type = "host";
                    key = " ";
                }
                {
                    type = "cpu";
                    key = " ";
                }
                {
                    type = "gpu";
                    key = "󰢮 ";
                }
                {
                    type = "memory";
                    key = " ";
                }
                {
                    type = "swap";
                    key = "󰾴 ";
                }
                {
                    type = "disk";
                    format = "{size-used} / {size-total} {?name}({name}){?}";
                    key = "󰋊 ";
                }
                {
                    type = "localip";
                    key = "󰩠 ";
                    showIpv4 = true;
                    showIpv6 = false;
                    showPrefixLen = false;
                }
            ];
        };
    };

    programs.hyfetch = {
        enable = true;

        settings = {
            preset = "transgender";
            mode = "rgb";
            light_dark = "dark";
            lightness = 0.65;
            color_align.mode = "horizontal";

            backend = "fastfetch";
            args = "-c ${config.home.homeDirectory}/.config/fastfetch/minimal.jsonc";
            distro = "nixos_small";
            pride_month_shown = [];
            pride_month_disable = false;
        };
    };
}
