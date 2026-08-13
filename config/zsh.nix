{ config, pkgs, lib, ... }:

{
    home.file.".p10k.zsh" = {
        source = ./p10k-config;
        executable = true;
    };

    programs.zsh = {
        enable = true;

        # Syntax highlighting
        syntaxHighlighting.enable = true;

        # Autocompletions
        enableCompletion = true;

        # Autosuggestions
        autosuggestion.enable = true;

        # History
        history = {
            size = 10000;
            save = 10000;
            path = "$HOME/.zsh_history";

            append = true;
            share = true;
            ignoreSpace = true;
            ignoreAllDups = true;
            saveNoDups = true;
            ignoreDups = true;
            findNoDups = true;
        };

        initContent = lib.mkMerge [
            (lib.mkOrder 100 ''
                hyfetch
            '')

            (lib.mkOrder 500 ''
                if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
                    source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
                fi
            '')

            (lib.mkOrder 1000 ''
                [[ -r "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"
            '')

            (lib.mkOrder 1500 ''
                bindkey '^[[A' history-search-backward
                bindkey '^[[B' history-search-forward
            '')
        ];

        # Plugins
        oh-my-zsh = {
            enable = true;
            plugins = [
                # Background notify
                "bgnotify"

                # Auto load dotenv
                "dotenv"

                # Colored contents
                "colored-man-pages"
                "colorize"

                # Base64
                "encode64"
            ];

            extraConfig = ''
                zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
                zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
                zstyle ':completion:*' menu no
                zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

                bgnotify_threshold=8
            '';
        };

        plugins = [
            {
                name = "fzf-tab";
                src = pkgs.zsh-fzf-tab;
                file = "share/fzf-tab/fzf-tab.zsh";
            }
            {
                name = "powerlevel10k";
                src = pkgs.zsh-powerlevel10k;
                file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
            }
        ];
        localVariables.POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD = true;

        # Aliases
        shellAliases = {
            fastfetch = "fastfetch --kitty ${../assets/nbix.png}";
            fetch = "fastfetch";
            ls = "eza --icons --group-directories-first --hyperlink";
            grep = "grep --color=auto";
            cd = "z";
            zed = "zeditor";

            switch = "sudo nixos-rebuild switch --flake \"${config.home.homeDirectory}/.dotfiles?submodules=1#laptop\"";
            hard-cleanup = "sudo ${config.home.homeDirectory}/.dotfiles/hard-cleanup.sh";
        };
    };

    programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
    };

    programs.fzf.enableZshIntegration = true;
    programs.nix-index.enable = true;
}
