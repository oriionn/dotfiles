{ pkgs, config, ... }:

{
    # Docker
    virtualisation.docker = {
        enable = false;
        rootless = {
            enable = true;
            setSocketVariable = true;
        };
    };

    # Virtual Machines
    virtualisation.libvirtd = {
        enable = true;
        onBoot = "start";
        onShutdown = "shutdown";
    };
    programs.virt-manager.enable = true;

    # Waydroid
    virtualisation.waydroid = {
        enable = true;
        package = if config.networking.nftables.enable
            then pkgs.waydroid-nftables
            else pkgs.waydroid;
    };
    environment.systemPackages = [ pkgs.wl-clipboard ];
}
