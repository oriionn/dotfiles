{ config, ... }:

let
  home = config.users.users.orion.home;
in
{
    home-manager.users.orion.xdg.userDirs = {
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
        screenshots = "${home}/Images/Copies d'écran";
    };
    home-manager.users.orion.xdg.configFile."user-dirs.locale".text = "fr_FR.UTF-8";

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
