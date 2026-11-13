{ pkgs, ... }:

{
    services.udev.packages = with pkgs; [
        sane-airscan
        (pkgs.writeTextFile {
            name = "rog-pelta-udev-rules";
            destination = "/etc/udev/rules.d/60-rog-pelta.rules";
            text = ''
                # ROG PELTA, USB-C cable
                KERNEL=="hidraw*", ATTRS{idVendor}=="0b05", ATTRS{idProduct}=="1b82", TAG+="uaccess"
                # ROG PELTA, 2.4 GHz dongle
                KERNEL=="hidraw*", ATTRS{idVendor}=="0b05", ATTRS{idProduct}=="1b84", TAG+="uaccess"
            '';
        })
    ];
}
