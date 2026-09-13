{ pkgs, inputs, ... }:

{
    wayland.windowManager.hyprland = {
        enable = true;

        systemd.enable = true;

        portalPackage = pkgs.xdg-desktop-portal-hyprland;

        xwayland.enable = true;
        configType = "lua";

        extraConfig = builtins.readFile ./hyprland.lua;
    };

    xdg.configFile."hypr/hyprsplit/init.lua" = {
        force = true;
        text = builtins.readFile "${inputs.hyprsplit}/init.lua";
    };

    xdg.configFile."hypr/xdph.conf".source = ./xdph.conf;
}
