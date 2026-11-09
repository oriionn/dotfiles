{ pkgs, ... }:

{
    programs.binary-ninja = {
        enable = true;
        package = pkgs.binary-ninja-free-wayland.overrideAttrs (old: {
            src = old.src.overrideAttrs (_: {
                outputHash = "sha256-2gp0g7mSK0Kal4oqn2U2YY5iaKVAyEXhQcMfx6i7U80=";
            });
        });
    };
}
