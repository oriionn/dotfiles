{ config, pkgs, ... }:

{
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

        initContent = ''
            bindkey '^[[A' history-search-backward
            bindkey '^[[B' history-search-forward
        '';

        # Plugins
        oh-my-zsh = {
            enable = true;
            plugins = [
                # Background notify
                "bgnotify"

                # Command not found
                "command-not-found"

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

        home.file.".p10k.zsh" = {
            source = ./p10k-config;
            executable = true;
        };

        # Aliases
        shellAliases = {
            fastfetch = "fastfetch --kitty ${../assets/arch_bi.png}";
            fetch = "fastfetch";
            ls = "eza --icons --group-directories-first --hyperlink";
            grep = "grep --color=auto";
            cd = "z";
            zed = "zeditor";

            switch = "sudo nixos-rebuild switch --flake \"${config.home.homeDirectory}/.dotfiles?submodules=1#laptop\"";
        };
    };

    programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
    };

    programs.fzf.enableZshIntegration = true;
}
