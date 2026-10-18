{ config, pkgs, ... }:

let
    sock = "/run/tailscale-core/tailscaled.sock";
in
{
     services.tailscale = {
         enable = true;
         interfaceName = "userspace-networking";

         extraDaemonFlags = [
             "--socks5-server=localhost:1055"
             "--outbound-http-proxy-listen=localhost:1055"
         ];

         extraSetFlags = [
             "--exit-node=100.109.116.126"
             "--exit-node-allow-lan-access=true"
             "--operator=orion"
         ];
    };

    # Tailscale CORE
    systemd.services.tailscaled-core = {
        description = "Tailscale (CORE)";
        after = [ "network-pre.target" ];
        wants = [ "network-pre.target" ];
        wantedBy = [ "multi-user.target" ];

        serviceConfig = {
            ExecStart = ''
                ${config.services.tailscale.package}/bin/tailscaled \
                --state=/var/lib/tailscale-core/tailscaled.state \
                --socket=${sock} \
                --port=41642 \
                --tun=userspace-networking \
                --socks5-server=localhost:1056 \
                --outbound-http-proxy-listen=localhost:1056
            '';
            RuntimeDirectory = "tailscale-core";
            StateDirectory = "tailscale-core";
            Restart = "on-failure";
        };
    };

    environment.systemPackages = [
        (pkgs.writeShellScriptBin "core-tailscale" ''
            exec ${config.services.tailscale.package}/bin/tailscale \
            --socket=/run/tailscale-core/tailscaled.sock "$@"
        '')
    ];

    networking.firewall.allowedUDPPorts = [ 41642 ];
}
