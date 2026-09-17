{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        penpot-desktop
        obsidian
#        freecad
        remmina
        cura-appimage
        deskreen
    ];
}
