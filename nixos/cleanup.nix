{ ... }:

{
    nix.gc = {
        automatic = true;
        dates = "weekly";
        persistent = true;
        options = "--delete-older-than 30d";
    };

    nix.optimise = {
        automatic = true;
        dates = [ "weekly" ];
    };

    systemd.services.nix-gc.serviceConfig.ExecStartPost =
        "/run/current-system/bin/switch-to-configuration boot";
}
