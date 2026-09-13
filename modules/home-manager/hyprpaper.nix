{
    wayland.systemd.target = "hyprland-session.target";

    services.hyprpaper = {
        enable = true;
        settings = {
            wallpaper = [
                {
                    monitor = "DP-9";
                    path = "${../../assets/wallpapers/screen1.jpg}";
                }
                {
                    monitor = "DP-11";
                    path = "${../../assets/wallpapers/screen2.png}";
                }
                {
                    monitor = "eDP-1";
                    path = "${../../assets/wallpapers/screen1.jpg}";
                }
            ];
        };
    };
}
