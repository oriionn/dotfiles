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
}
