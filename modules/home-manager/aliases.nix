{ config, lib, configName, ... }:

{
    home.shellAliases = {
        fastfetch = "fastfetch --kitty ${../../assets/nbix.png}";
        fetch = "fastfetch";
        ls = "eza --icons --group-directories-first --hyperlink";
        grep = "grep --color=auto";
        cd = "z";
        zed = "zeditor";

        switch = "sudo nixos-rebuild switch --flake \"${config.home.homeDirectory}/.dotfiles?submodules=1#laptop\"";
        hard-cleanup = "sudo ${../../hard-cleanup.sh}";
        clear = "pyroclear";
    } // lib.optionalAttrs (configName == "laptop") {
        reboot-to-windows = "systemctl reboot --boot-loader-entry=auto-windows";
        sshome = "ssh -4 -o ProxyCommand=\"socat - SOCKS5:localhost:1055:%h:%p\"";
        ofetch = "ofetch -t=\"    Framework  \"";
    };
}
