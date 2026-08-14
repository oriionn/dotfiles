{ unstable, hyprsplit, ... }:

{
    wayland.windowManager.hyprland = {
        enable = true;

        systemd.enable = true;

        package = unstable.hyprland;
        portalPackage = unstable.xdg-desktop-portal-hyprland;

        xwayland.enable = true;
        configType = "lua";

        extraConfig = builtins.readFile ./hyprland.lua;
    };
    xdg.configFile."hypr/hyprsplit/init.lua" = {
        force = true;
        text = builtins.readFile "${hyprsplit}/init.lua";
    };

    xdg.configFile."hypr/xdph.conf".source = ./xdph.conf;
}
