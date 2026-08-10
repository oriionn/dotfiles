{ config, ... }:

{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
      };

      background = [
        {
          monitor = "";
          path = "${config.home.homeDirectory}/.dotfiles/assets/wallpapers/screen2.png";

          blur_size = 4;
          blur_passes = 3;
          noise = 0.0117;
          contrast = 1.3;
          brightness = 0.8;
          vibrancy = 0.21;
          vibrancy_darkness = 0.0;
        }
      ];

      # Hours
      label = [
        {
          monitor = "";
          text = ''cmd[update:1000] date +"%H"'';

          color = "#fff";
          font_size = 112;
          font_family = "Geist Mono 10";

          shadow_passes = 3;
          shadow_size = 4;

          position = "0, 220";
          halign = "center";
          valign = "center";
        }

        # Minutes
        {
          monitor = "";
          text = ''cmd[update:1000] date +"%M"'';

          color = "#fff";
          font_size = 112;
          font_family = "Geist Mono 10";

          shadow_passes = 3;
          shadow_size = 4;

          position = "0, 80";
          halign = "center";
          valign = "center";
        }

        # Today
        {
          monitor = "";
          text = ''cmd[update:18000000] date +"%A %d %b"'';

          color = "#fff";
          font_size = 22;
          font_family = "JetBrainsMono Nerd Font 10";

          position = "0, -15";
          halign = "center";
          valign = "center";
        }

        # Degrees
        {
          monitor = "";
          text = ''
            cmd[update:18000000] echo "Ressenti $(curl -s 'wttr.in?format=%t' | tr -d '+') "
          '';

          color = "#fff";
          font_size = 18;
          font_family = "Geist Mono 10";

          position = "0, 40";
          halign = "center";
          valign = "bottom";
        }
      ];

      "input-field" = [
        {
          monitor = "";

          size = "250, 50";
          outline_thickness = 3;

          dots_size = 0.26;
          dots_spacing = 0.64;
          dots_center = true;
          dots_rounding = -1;

          rounding = 22;
          font_color = "#fff";
          fade_on_empty = true;
          placeholder_text = "<i>Password...</i>";

          position = "0, 120";
          halign = "center";
          valign = "bottom";
        }
      ];
    };
  };
}
