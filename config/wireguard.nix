{pkgs, ...}: {
  networking.wg-quick.interfaces = let
    server_ip = "149.88.103.38";
  in {
    wg0 = {
      address = [
        "10.2.0.2/32"
      ];

      listenPort = 51820;

      privateKey = "uFMQ1B97z39U0oHRlyaw3UR+paKarOwuQey+rHxtsWs=";
      dns = ["10.2.0.1"];

      peers = [
        {
          publicKey = "80qDNuS6cbRa6m0nxDBaJxz4fU0VRaGWvIa5mGMZ1WI=";
          allowedIPs = ["0.0.0.0/0" "::/0"];
          endpoint = "${server_ip}:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
# [Interface]
# # Bouncing = 0
# # NAT-PMP (Port Forwarding) = off
# # VPN Accelerator = on
# PrivateKey = uFMQ1B97z39U0oHRlyaw3UR+paKarOwuQey+rHxtsWs=
# Address = 10.2.0.2/32
# DNS = 10.2.0.1
#
# [Peer]
# # JP-FREE#30
# PublicKey = 80qDNuS6cbRa6m0nxDBaJxz4fU0VRaGWvIa5mGMZ1WI=
# AllowedIPs = 0.0.0.0/0
# Endpoint = 149.88.103.38:51820

