{ pkgs, ... }: {
    programs.ghostty = {
        enable = true;
        package = pkgs.ghostty;
        enableZshIntegration = true;

        settings = {
            background = "191A23";
            font-family = "JetBrainsMono Nerd Font Mono";
            font-size = "13";

            background-blur = true;
            background-opacity = "0.7";

            custom-shader = [
                "${./shaders/cursor_tail.glsl}"
                "${./shaders/sonic_boom_cursor.glsl}"
            ];
        };
    };
}
