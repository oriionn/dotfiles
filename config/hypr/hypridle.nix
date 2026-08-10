{ config, ... }:

let
  unstable = import (builtins.fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz"
  ) {};
in
{
    services.hypridle = {
        enable = true;
        systemdTarget = "hyprland-session.target";

        settings = {
            general = {
                lock_cmd = "pidof hyprlock || hyprlock";
                unlock_cmd = 'notify-send "Hyprlock" "Session déverouillée" --app-name="Hyprlock" --icon=${config.home.homeDirectory}/.dotfiles/assets/icons/unlock.png';
                ignore_dbus_inhibit = false;
                before_sleep_cmd = "loginctl lock-session";
                after_sleep_cmd = "hyprctl dispatch dpms on";
            };

            listener = [
                {
                    timeout = 600;
                    on-timeout = "hyprlock"
                    on-resume = 'notify-send "Hyprlock" "Session déverouillée" --app-name="Hyprlock" --icon=${config.home.homeDirectory}/.dotfiles/assets/icons/unlock.png'
                }
            ];
        };
    }
}
