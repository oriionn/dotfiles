{ pkgs, ... }:

{
    services.udev.extraRules = ''
    # This rule was added by Solaar.
    #
    # Allows non-root users to have raw access to Logitech devices.
    # Allowing users to write to the device is potentially dangerous
    # because they could perform firmware updates.

    ACTION == "remove", GOTO="solaar_end"
    SUBSYSTEM != "hidraw", GOTO="solaar_end"

    # USB-connected Logitech receivers and devices
    ATTRS{idVendor}=="046d", GOTO="solaar_apply"

    # Lenovo nano receiver
    ATTRS{idVendor}=="17ef", ATTRS{idProduct}=="6042", GOTO="solaar_apply"

    # Bluetooth-connected Logitech devices
    KERNELS == "0005:046D:*", GOTO="solaar_apply"

    GOTO="solaar_end"

    LABEL="solaar_apply"

    # Allow any seated user to access the receiver.
    # uaccess: modern ACL-enabled udev
    TAG+="uaccess"

    # Grant members of the "plugdev" group access to receiver (useful for SSH users)
    #MODE="0660", GROUP="plugdev"

    LABEL="solaar_end"
    # vim: ft=udevrules
        '';

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
