{ pkgs, ... }:

{
    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.configurationLimit = 5;

    # Plymouth
    boot.plymouth = {
        enable = true;
        theme = "blahaj";
        themePackages = with pkgs; [
            (plymouth-blahaj-theme.overrideAttrs (old: {
                postInstall = (old.postInstall or "") + ''
                    install -Dm644 ${../../assets/boot.png} \
                        $out/share/plymouth/themes/blahaj/watermark.png

                    substituteInPlace \
                        $out/share/plymouth/themes/blahaj/blahaj.plymouth \
                        --replace-fail \
                            "WatermarkVerticalAlignment=.96" \
                            "WatermarkVerticalAlignment=.88"

                    ${imagemagick}/bin/magick mogrify \
                        -resize 150% \
                        $out/share/plymouth/themes/blahaj/animation-*.png \
                        $out/share/plymouth/themes/blahaj/throbber-*.png
                '';
            }))
        ];
    };

    boot.consoleLogLevel = 3;
    boot.initrd.verbose = false;
    boot.kernelParams = [
        "quiet"
        "rd.udev.log_level=3"
        "rd.systemd.show_status=auto"
    ];
}
