{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        (prismlauncher.override {
            additionalPrograms = [ ffmpeg ];

            jdks = [
                temurin-bin-8
                zulu17
                zulu21
                zulu25
                zulu
            ];
        })
        steam
        supertuxkart
        supertuxkart-server
        supertux
    ];
}
