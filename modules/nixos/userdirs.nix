{ config, username, ... }:

let
  home = config.users.users.${username}.home;
in
{
    home-manager.users.${username} = {
        xdg.userDirs = {
            enable = true;
            createDirectories = true;

            desktop = "${home}/Bureau";
            documents = "${home}/Documents";
            download = "${home}/Téléchargements";
            music = "${home}/Musique";
            pictures = "${home}/Images";
            publicShare = "${home}/Public";
            templates = "${home}/Modèles";
            videos = "${home}/Vidéos";

            extraConfig = {
                SCREENSHOTS = "${home}/Images/Copies d'écran";
            };
        };
        xdg.configFile."user-dirs.locale" = {
            text = "fr_FR.UTF-8";
            force = true;
        };
        xdg.configFile."user-dirs.dirs".force = true;
    };

    environment.sessionVariables = {
        XDG_DESKTOP_DIR = "\${HOME}/Bureau";
        XDG_DOCUMENTS_DIR = "\${HOME}/Documents";
        XDG_DOWNLOAD_DIR = "\${HOME}/Téléchargements";
        XDG_MUSIC_DIR = "\${HOME}/Musique";
        XDG_PICTURES_DIR = "\${HOME}/Images";
        XDG_SCREENSHOTS_DIR = "\${HOME}/Images/Copies d'écran";
        XDG_PUBLICSHARE_DIR = "\${HOME}/Public";
        XDG_TEMPLATES_DIR = "\${HOME}/Modèles";
        XDG_VIDEOS_DIR = "\${HOME}/Vidéos";

        # Hyprquickshot
        HQS_DIR = "\${HOME}/Images/Copies d'écran";
    };
}
