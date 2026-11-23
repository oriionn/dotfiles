{ config, lib, ... }:

let
    user = config.home.username;
    debianHome = "distrobox/debian";
    files = config.home.file;

    debianZshPre = ''
        alias ofetch='ofetch -t="   Debian  " --preset=lesbian --distro debian'
    '';

    debianZshPost = ''
        not-in-nix() {
            echo "Tu n'es pas sur ton shell principal"
            return 1
        }

        for cmd in reboot-to-windows switch ssh hard-cleanup; do
            (( ''${+aliases[$cmd]} )) && unalias $cmd
            functions[$cmd]='not-in-nix'
        done

        HISTFILE="${config.home.homeDirectory}/.zsh_history"

        typeset -g POWERLEVEL9K_TOOLBOX_FOREGROUND=161
        typeset -g POWERLEVEL9K_TOOLBOX_VISUAL_IDENTIFIER_EXPANSION=$''
    '';
in
{
    programs.distrobox = {
        enable = true;
        containers = {
            debian = {
                image = "debian:stable";
                entry = true;
                additional_packages = "git build-essential curl";
                # common zsh bin
                init_hooks = "usermod --shell /run/host/run/current-system/sw/bin/zsh ${user}";
                home = "${config.home.homeDirectory}/${debianHome}";
                additional_flags = "--hostname fw-debian";
            };
        };
    };

    home.file = {
        "${debianHome}/.zshrc".source = files."./.zshrc".source;
        "${debianHome}/.zshenv".source = files."./.zshenv".source;
        "${debianHome}/.p10k.zsh".source = files.".p10k.zsh".source;
        "${debianHome}/.zshrc.debian-pre".text = debianZshPre;
        "${debianHome}/.zshrc.debian-post".text = debianZshPost;
    };

    programs.zsh.initContent = lib.mkMerge [
        # Common path
        (lib.mkOrder 50 ''
            if [[ -n "''${CONTAINER_ID-}" || -e /run/.containerenv ]]; then
                path+=(
                    ${config.home.homeDirectory}/.nix-profile/bin
                    /run/host/run/current-system/sw/bin
                )
                ZSH_DISABLE_COMPFIX=true
            fi
        '')

        # Custom Debian zsh
        (lib.mkOrder 60 ''
            if [[ "''${CONTAINER_ID-}" == "debian" && -r "$HOME/.zshrc.debian-pre" ]]; then
                source "$HOME/.zshrc.debian-pre"
            fi
        '')
        (lib.mkOrder 3000 ''
            if [[ "''${CONTAINER_ID-}" == "debian" && -r "$HOME/.zshrc.debian-post" ]]; then
                source "$HOME/.zshrc.debian-post"
            fi
        '')
    ];
}
