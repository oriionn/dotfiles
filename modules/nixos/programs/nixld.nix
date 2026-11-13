{ pkgs, ... }:

{
    programs.nix-ld = {
        enable = true;

        libraries = with pkgs; [
            libxcb
            libxcb-cursor
            libxcb-wm
            libxcb-image
            libxcb-keysyms
            libxcb-render-util
            qt6.qtwayland
        ];
    };
}
