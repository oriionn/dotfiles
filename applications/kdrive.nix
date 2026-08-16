{ pkgs, config, ... }:

{
    home.file.".bin/kDrive.AppImage" = {
        source = pkgs.fetchurl {
            url = "https://https://download.storage.infomaniak.com/drive/desktopclient/kDrive-3.8.5.2-amd64.AppImage"
            sha256 = "00k4fgsbwkxvyzjk7byx9jlbcp5m07w7lz54129d3wy8w5vkprzi"
        };
        executable = true;
    };

    xdg.desktopEntries.kdrive = {
        type = "Application";
        name = "kDrive";
        exec = "appimage-run ${config.xdg.configHome}/.bin/kDrive.AppImage";
        icon = "${../assets/icons/kdrive.png}";
        terminal = false;
        categories = [ "Utility" ];
    };
}
