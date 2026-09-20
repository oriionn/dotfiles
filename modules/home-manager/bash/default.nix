{ lib, pkgs, ... }:

{
    home.packages = with pkgs; [
        blesh
    ];

    programs.bash = {
        enable = true;
        initExtra = lib.mkMerge [
            (lib.mkOrder 10 ''
                [[ $- == *i* ]] && source -- "$(blesh-share)"/ble.sh --attach=none
            '')

            (lib.mkOrder 100 ''
                ofetch -t="    Framework  "
            '')

            (lib.mkOrder 200 ''
                eval "$(starship init bash)"
            '')

            (lib.mkOrder 1000 ''
                [[ ! ''${BLE_VERSION-} ]] || ble-attach
            '')
        ];
    };

    xdg.configFile."blesh/init.sh".text = ''
        bleopt prompt_ps1_transient=trim
        bleopt prompt_ps1_final='$(starship module character)'

        ble-face auto_complete='fg=8'
        ble-import -d integration/fzf-menu
    '';

    programs.starship = {
        enable = true;
        enableBashIntegration = false;
        enableZshIntegration = false;

        settings = {
            format = ''
                [$directory](fg:#57c7ff) [$git_branch](fg:#6c6c6c)
                $nix_shell[$character](fg:#ff6ac1)'';

            right_format = "[$cmd_duration](fg:#f3f99d) [$time](fg:#6c6c6c)";

            git_branch = {
                format = "$branch";
            };

            directory = {
                format = "$path";
            };

            fill = {
                symbol = " ";
            };

            cmd_duration = {
                format = "$duration";
            };

            time = {
                format = "$time";
                disabled = false;
            };

            nix_shell = {
                format = "[$symbol$state\\($name\\)]($style) ";
                symbol = "󱄅 ";
            };
        };
    };

    programs.zoxide.enableBashIntegration = true;
}
