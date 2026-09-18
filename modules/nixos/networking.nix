{ pkgs, ... }:

{
    networking.firewall.allowedTCPPorts = [
        3131 # Deskreen
    ];

    # Network Manager
    networking.networkmanager = {
        enable = true;
        dns = "systemd-resolved";

        plugins = with pkgs; [
            networkmanager-openconnect
            networkmanager-fortisslvpn
        ];
    };

    services.resolved = {
        enable = true;

        settings.Resolve = {
            DNS = [
                "194.242.2.2 #dns.mullvad.net"
                "1.1.1.1 #cloudflare-dns.com"
                "1.0.0.1 #cloudflare-dns.com"
            ];

            FallbackDNS = "";
            Domains = "~.";
            DNSSEC = "allow-downgrade";
            DNSOverTLS = "yes";
        };
    };
}
