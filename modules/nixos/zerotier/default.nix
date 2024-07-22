{
  lib,
  config,
  ...
}: let
  cfg = config.modules.zerotier;
in {
  imports = [
    ./systemd-manager.nix
  ];

  options.modules.zerotier.enable = lib.mkEnableOption "Enable zerotier";
  options.modules.zerotier.port = lib.mkOption {
    description = "port for zerotier";
    default = 9993;
  };
  config = lib.mkIf cfg.enable {
    services.zerotierone = let
      networkId = "272f5eae1653139f";
    in {
      enable = true;
      joinNetworks = [networkId];
      localConf = {
        settings.allowTcpFallbackRelay = true;
      };
      port = cfg.port;
    };

    #    environment.persistence."/persist/system" = {
    #      directories = ["/var/lib/zerotier-one"];
    #    };
  };
}
