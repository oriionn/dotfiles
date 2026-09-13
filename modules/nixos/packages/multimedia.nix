{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        vlc
        delfin
        feishin
    ];
}
