{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        obsidian
#        freecad
        remmina
        cura-appimage
        deskreen
        ghidra
        kdePackages.skanlite
        gimp
        screen
        picocom
    ];
}
