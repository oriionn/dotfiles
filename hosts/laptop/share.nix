{
    # Share partition
    systemd.tmpfiles.rules = [
        "d /mnt/Partage 0755 root root -"
    ];

    fileSystems."/mnt/Partage" = {
        device = "/dev/disk/by-uuid/1ED2-B79F";
        fsType = "exfat";
        options = [
            "defaults"
            "uid=1000"
            "gid=100"
            "umask=002"
        ];
    };

    systemd.services.create-partage-hidden = {
        wantedBy = [ "multi-user.target" ];
        after = [ "mnt-Partage.mount" ];
        requires = [ "mnt-Partage.mount" ];

        serviceConfig.Type = "oneshot";

        script = ''
            cat > /mnt/Partage/.hidden <<'EOF'
System Volume Information
$RECYCLE.BIN
        EOF
        '';
    };
}
