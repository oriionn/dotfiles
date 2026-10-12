{
    boot.zswap = {
        enable = true;
        compressor = "zstd";
        maxPoolPercent = 20;
        shrinkerEnabled = true;
    };
    zramSwap.enable = false;

    swapDevices = [
        {
            device = "/var/lib/swapfile";
            size = 64 * 1024;
        }
    ];
}
