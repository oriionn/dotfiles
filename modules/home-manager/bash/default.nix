{ lib, ... }:

{
    programs.bash = {
        enable = true;
        initExtra = lib.mkMerge [
            (lib.mkOrder 100 ''
                ofetch -t="    Framework  "
            '')
        ];

    };

    programs.starship = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = false;

        settings = {
            format = "";
        };
    };

    programs.zoxide.enableBashIntegration = true;
}
