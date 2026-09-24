{ config, lib, configName, pkgs, ... }:

let
    gcc = pkgs.writeShellScriptBin "gcc" ''
        REAL_GCC="/run/current-system/sw/bin/gcc"

        DEFAULT_FLAGS=(-Wall -Wextra -Wpedantic -Werror)
        SCHOOL_FLAGS=(-std=c17)

        args=()
        output_set=false
        source_file=""

        for arg in "$@"; do
            if [[ "$arg" == "--school" ]]; then
                args+=("''${SCHOOL_FLAGS[@]}")
            else
                args+=("$arg")

                # Détecte -ofoo
                if [[ "$arg" == -o?* ]]; then
                    output_set=true
                fi

                # Récupère le fichier C
                if [[ "$arg" == *.c ]]; then
                    source_file="$arg"
                fi
            fi
        done

        for ((i = 0; i < ''${#args[@]}; i++)); do
            if [[ "''${args[i]}" == "-o" ]]; then
                output_set=true
                break
            fi
        done

        if [[ "$output_set" == false && -n "$source_file" ]]; then
            output="''${source_file##*/}"
            output="''${output%.c}"
            args+=("-o" "$output")
        fi

        exec "$REAL_GCC" "''${args[@]}"
    '';
in
{
    home.shellAliases = {
        fastfetch = "fastfetch --kitty ${../../assets/nbix.png}";
        fetch = "fastfetch";
        ls = "eza --icons --group-directories-first --hyperlink";
        grep = "grep --color=auto";
        cd = "z";
        zed = "zeditor";
        clear = "pyroclear";

        switch = "sudo nixos-rebuild switch --flake \"${config.home.homeDirectory}/.dotfiles?submodules=1#laptop\"";
        hard-cleanup = "sudo ${../../hard-cleanup.sh}";
        gcc = "${gcc}/bin/gcc";
        sgcc = "";
    } // lib.optionalAttrs (configName == "laptop") {
        reboot-to-windows = "systemctl reboot --boot-loader-entry=auto-windows";
        sshome = "ssh -4 -o ProxyCommand=\"socat - SOCKS5:localhost:1055:%h:%p\"";
        ofetch = "ofetch -t=\"    Framework  \"";
    };
}
