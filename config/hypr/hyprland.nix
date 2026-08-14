{ unstable, hyprsplit, ... }:

{
    wayland.windowManager.hyprland = {
        enable = true;

        systemd.enable = true;

        package = unstable.hyprland;
        portalPackage = unstable.xdg-desktop-portal-hyprland;

        xwayland.enable = true;
        configType = "lua";
    };
    xdg.configFile."hypr/hyprsplit/init.lua" = {
        force = true;
        content = builtins.readFile "${hyprsplit}/init.lua";
    }
    xdg.configFile."hypr/hyprland.lua" = {
        force = true;
        source = ./hyprland.lua;
    }

    xdg.configFile."hypr/xdph.conf".source = ./xdph.conf;
}
