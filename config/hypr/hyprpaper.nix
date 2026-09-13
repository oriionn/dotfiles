{ unstable, config, ... }:

{
    wayland.systemd.target = "hyprland-session.target";

    services.hyprpaper = {
        enable = true;
        package = unstable.hyprpaper;

        settings = {
            wallpaper = [
                {
                    monitor = "DP-9";
                    path = "${config.home.homeDirectory}/.dotfiles/assets/wallpapers/screen1.jpg";
                }
                {
                    monitor = "DP-11";
                    path = "${config.home.homeDirectory}/.dotfiles/assets/wallpapers/screen2.png";
                }
                {
                    monitor = "eDP-1";
                    path = "${config.home.homeDirectory}/.dotfiles/assets/wallpapers/screen1.jpg";
                }
            ];
        };
    };
}
