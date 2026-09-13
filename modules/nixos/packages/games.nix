{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        (prismlauncher.override {
            additionalPrograms = [ ffmpeg ];

            jdks = [
                zulu8
                zulu17
                zulu21
                zulu25
                zulu
            ];
        })
        steam
    ];
}
