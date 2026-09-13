{ pkgs, hyprquickshot, ... }:

{
    environment.systemPackages = with pkgs; [
        hyprpolkitagent
        hyprquickshot
        hyprpicker
    ];
}
