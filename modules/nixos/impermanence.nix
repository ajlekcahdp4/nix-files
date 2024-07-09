{
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.impermanence;
in {
  imports = [
    inputs.impermanence.nixosModules.impermanence
    inputs.disko.nixosModules.default
  ];

  options.modules.impermanence.enable = lib.mkEnableOption "Enable impermanence";

  config = lib.mkIf cfg.enable {
    fileSystems."/persist".neededForBoot = true;
    environment.persistence."/persist/system" = {
      hideMounts = true;
      directories = [
        "/etc/nixos"
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager"
        {
          directory = "/var/lib/colord";
          user = "colord";
          group = "colord";
          mode = "u=rwx,g=rx,o=";
        }
      ];
      files = [
        "/etc/machine-id"
      ];
    };
  };
}
