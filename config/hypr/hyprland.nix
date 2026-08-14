{ unstable, hyprsplit, ... }:

{
    wayland.windowManager.hyprland = {
        enable = true;

        systemd.enable = true;

        package = unstable.hyprland;
        portalPackage = unstable.xdg-desktop-portal-hyprland;

        xwayland.enable = true;

        configType = "lua";
        extraLuaFiles = {
            # create a symlink to `.config/hypr/hyprsplit/init.lua`.
            "hyprsplit/init" = {
                autoLoad = false;
                content = builtins.readFile "${hyprsplit}/init.lua";
            };
            # Finally, use it directly in Lua.
            "hyprload" = {
                autoLoad = true;
                content = ./hyprland.lua;
            };
        };
    };

    xdg.configFile."hypr/xdph.conf".source = ./xdph.conf;
}
