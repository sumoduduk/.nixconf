{pkgs, ...}: {
  networking.wg-quick.interfaces = let
    server_ip = "18.19.23.66";
  in {
    wg0 = {
      address = [
        "10.64.186.60/32"
        "fdc9:281f:04d7:9ee9::2/64"
      ];

      listenPort = 51820;

      privateKeyFile = "/etc/mullvad-vpn.key";

      peers = [
        {
          publicKey = "1493vtFUbIfSpQKRBki/1d0YgWIQwMV4AQAvGxjCNVM=";
          allowedIPs = ["0.0.0.0/0"];
          endpoint = "${server_ip}:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
