{ config, ... }:

{
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
