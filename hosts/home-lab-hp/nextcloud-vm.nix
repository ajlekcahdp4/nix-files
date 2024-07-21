{
  pkgs,
  lib,
  config,
  ...
}: let
  bridgeName = "virbr0";
  vmMacAddr = "02:00:00:00:00:02";
  vmTapId = "vm-nextcloud";
in {
  microvm.vms = {
    nextcloud-microvm = {
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
          networks."${bridgeName}" = {
            matchConfig.Name = bridgeName;
            networkConfig = {
              Address = ["192.168.90.3/24" "2001:db8::b/64"];
              Gateway = "192.168.90.2";
              DNS = "192.168.90.2";
              IPv6AcceptRA = true;
            };
          };
        };
        users.users.root.openssh.authorizedKeys.keys = [
          (builtins.readFile ./microvm-key.pub)
        ];
        services.openssh = {
          enable = true;
          settings.PermitRootLogin ="yes";
        };
        networking.hostName = "nextcloud-microvm";
        system.stateVersion = config.system.nixos.version;
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
    networks."${bridgeName}" = {
      matchConfig.Name = bridgeName;
      networkConfig = {
        Address = ["192.168.90.2/24" "2001:db8::a/64"];
        Gateway = ["192.168.90.1"];
        IPv6AcceptRA = true;
      };
    };
    
    networks."microvm-eth0" = {
      matchConfig.Name = "vm-*";
      networkConfig.Bridge = bridgeName;
    };
  };
    
  networking.nat = {
    enable = true;
    enableIPv6 = true;
    internalInterfaces = [ bridgeName ];
  };

  systemd.services."systemd-networkd".environment.SYSTEMD_LOG_LEVEL = "debug";
  networking.firewall.allowedUDPPorts = [67];
  networking.extraHosts = ''
    192.168.90.1 microvm-1
    192.168.90.2 microvm-2
    192.168.90.3 microvm-3
  '';
}
