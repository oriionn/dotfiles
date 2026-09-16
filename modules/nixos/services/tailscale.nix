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
         ];
     };
 }
