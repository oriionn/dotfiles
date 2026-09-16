{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        udiskie
        swaynotificationcenter
        nwg-bar
        kdePackages.dolphin
        brightnessctl
        xdg-utils
        networkmanagerapplet
        glib
        unzip
        solaar
        dnsmasq # Libvirtd network
        ffmpeg-full
        imagemagick
        nmap
        socat
    ];
}
