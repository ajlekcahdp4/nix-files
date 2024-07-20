{
  pkgs,
  lib,
  ...
}: let
  bridgeName = "bridge-to-nc-microvm-2";
  vmMacAddr = "02:00:00:00:00:02";
  vmTapId = "vm-nextcloud-2";
in {
  microvm.vms = {
    nextcloud-microvm-2 = {
      autostart = true;
      config = {
        microvm = {
          vcpu = 1;
          mem = 1024;
          hypervisor = "qemu";
          shares = [
            {
              source = "/nix/store";
              mountPoint = "/nix/.ro-store";
              tag = "ro-store";
              proto = "virtiofs";
            }
          ];
          interfaces = [
            {
              type = "tap";
              id = vmTapId;
              mac = vmMacAddr;
            }
          ];
        };

        systemd.network = {
          enable = true;
          networks."20-lan" = {
            matchConfig.Name = "ether";
            networkConfig = {
              Address = ["192.168.90.3/24" "2001:db8::b/64"];
              Gateway = "192.168.90.1";
              DNS = ["192.168.90.1"];
              IPv6AcceptRA = true;
              DHCP = "no";
            };
          };
        };

        networking.hostName = "nextcloud-microvm-2";
        system.stateVersion = "24.05";
      };
    };
  };
  users.users.root.openssh.authorizedKeys.keys = [
    (builtins.readFile ./microvm-key.pub)
  ];
  networking.hostName = "home-lab-hp";
  systemd.network = {
    enable = true;
    netdevs."${bridgeName}".netdevConfig = {
      Kind = "bridge";
      Name = bridgeName;
    };

    networks."10-lan" = {
      matchConfig.Name = bridgeName;
      networkConfig = {
        Address = ["192.168.90.2/24" "2001:db8::a/64"];
        Gateway = "192.168.90.1";
        DNS = "192.168.90.1";
        IPv6AcceptRA = true;
      };
    };

    networks."11-lan" = {
      matchConfig.Name = "vm-*";
      networkConfig.Bridge = bridgeName;
    };
  };
  systemd.services."systemd-networkd".environment.SYSTEMD_LOG_LEVEL = "debug";
  networking.firewall.allowedUDPPorts = [67];
}
