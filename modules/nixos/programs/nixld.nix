{ pkgs, ... }:

{
    programs.nix-ld = {
        enable = true;

        libraries = with pkgs; [
            libxcb
            libxcb-cursor
            xorg.xcbutilwm
            xorg.xcbutilimage
            xorg.xcbutilkeysyms
            xorg.xcbutilrenderutil
            qt6.qtwayland
        ];
    };
}
