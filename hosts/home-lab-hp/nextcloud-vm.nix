{
  pkgs,
  lib,
  config,
  ...
}: let
  config' = config.microvm.vms.nextcloud-microvm.config.config;
  bridgeName = "virbr0";
  vmMacAddr = "02:00:00:03:00:02";
  vmTapId = "vm-nextcloud";
in {
  microvm.vms = {
    nextcloud-microvm = {
      autostart = true;
      config = {
        microvm = {
          vcpu = 2;
          mem = 1024 * 4;
          hypervisor = "qemu";
          shares = [
            {
              source = "/nix/store";
              mountPoint = "/nix/.ro-store";
              tag = "ro-store";
              proto = "virtiofs";
            }
            {
            source = "/var/lib/microvms/nextcloud-vm/_state";
            mountPoint = "${config'.services.nextcloud.home}";
            tag = "state";
            proto = "virtiofs";
            socket = "state.sock";
          }
          {
            source = "/stank/nextcloud";
            mountPoint = "${config'.services.nextcloud.datadir}";
            tag = "data";
            proto = "virtiofs";
            socket = "data.sock";
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
        };
        users.users.root.initialPassword = "";
        users.users.alexander = {
          initialPassword = "test";
          isNormalUser = true;
          extraGroups = ["wheel"];
          openssh.authorizedKeys.keys = [
            (builtins.readFile ./microvm-key.pub)
          ];
        };
        users.users.root.openssh.authorizedKeys.keys = [
          (builtins.readFile ./microvm-key.pub)
        ];

        services.openssh = {
          enable = true;
          settings.PermitRootLogin = "no";
          settings.PasswordAuthentication = false;
          openFirewall = true;
        };

        services.getty.autologinUser = "alexander";
        services.nextcloud = {
          enable = true;
          hostName = "nextcloud.home";
          home = "/var/lib/nextcloud-home";
          datadir = "/data";
          package = pkgs.nextcloud29;
          config = {
            adminpassFile = "/etc/nextcloud-admin-pass";
          };
          settings = {
            trusted_proxies = ["192.168.90.1"];
            trusted_domains = ["localhost" "192.168.90.2" "185.180.231.81" "185.180.231.81:5623" "alexanderromanov.tech" "www.alexanderromanov.tech"];
          };
        };
        environment.etc."nextcloud-admin-pass".text = "11111111111";
        services.frp = {
          enable = true;
          role = "client";
          settings = {
            serverAddr = "185.180.231.81";
            serverPort = 7154;
            proxies = [
              {
                name = "web";
                type = "tcp";
                localIp = "127.0.0.1";
                localPort = 80;
                remotePort = 5623;
              }
            ];
          };
        };
        networking.hostName = "nextcloud-microvm";
        networking.firewall.allowedTCPPorts = [22 80 443];
        system.stateVersion = config.system.nixos.version;
      };
    };
  };
  users.users.root.openssh.authorizedKeys.keys = [
    (builtins.readFile ./microvm-key.pub)
  ];
  networking.networkmanager.enable = lib.mkForce true;
  networking.hostName = "home-lab-hp";
  systemd.network = {
    enable = true;
    netdevs."${bridgeName}".netdevConfig = {
      Kind = "bridge";
      Name = bridgeName;
    };
    networks."${bridgeName}" = {
      matchConfig.Name = bridgeName;
      addresses = [
        {Address = "192.168.90.1/24";}
        {Address = "fd12:3456:789a::1/64";}
      ];
      # Hand out IP addresses to MicroVMs.
      # Use `networkctl status virbr0` to see leases.
      networkConfig = {
        DHCPServer = true;
        IPv6SendRA = true;
      };
      # Let DHCP assign a statically known address to the VMs
      dhcpServerStaticLeases = [
        {
          MACAddress = vmMacAddr;
          Address = "192.168.90.2";
        }
      ];
      # IPv6 SLAAC
      ipv6Prefixes = [
        {
          Prefix = "fd12:3456:789a::/64";
        }
      ];
    };

    networks."microvm-eth0" = {
      matchConfig.Name = vmTapId;
      networkConfig.Bridge = bridgeName;
    };
  };

  networking.nat = {
    enable = true;
    enableIPv6 = true;
    internalInterfaces = [bridgeName];
  };
  services.nginx = {
    enable = true;
    virtualHosts."nextcloud.home" = {
      locations."/" = {
        proxyPass = "https://192.168.90.2:443";
      };
    };
  };
  systemd.services."systemd-networkd".environment.SYSTEMD_LOG_LEVEL = "debug";
  networking.firewall.allowedUDPPorts = [67];
  networking.extraHosts = ''
    192.168.90.2 nextcloud.home
  '';
  networking.useDHCP = lib.mkForce false;
}
