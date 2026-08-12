{ pkgs, ... }:

 {
     xdg.configFile."nwg-bar/bar.json".text = builtins.toJSON [
         {
            label = "Vérouiller";
            exec = "loginctl lock-session";
            icon = "${pkgs.nwg-bar}/share/nwg-bar/images/system-lock-screen.svg";
        }
        {
            label = "Déconnexion";
            exec = "hyprctl dispatch exit";
            icon = "${pkgs.nwg-bar}/share/nwg-bar/images/system-log-out.svg";
        }
        {
            label = "Redémarrer";
            exec = "systemctl reboot";
            icon = "${pkgs.nwg-bar}/share/nwg-bar/images/system-reboot.svg";
        }
        {
            label = "Éteindre";
            exec = "systemctl -i poweroff";
            icon = "${pkgs.nwg-bar}/share/nwg-bar/images/system-shutdown.svg";
        }
     ];

     xdg.configFile."nwg-bar/style.css".source = ./style.css;
 }
