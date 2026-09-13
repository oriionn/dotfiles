{ lib, ... }:

{
    services.flatpak = {
        enable = true;
        packages = [
            {
                appId = "com.hypixel.HytaleLauncher";
                bundle = "file://${../../../flatpaks/hytale/app.flatpak}";
                sha256 = lib.fileContents ../../../flatpaks/hytale/sha256.txt;
            }
        ];
        uninstallUnmanaged = true;
    };
}
