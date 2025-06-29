{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.greetd;
  inherit (lib) getExe;
in {
  options.modules.greetd.enable = lib.mkEnableOption "enable greetd";
  config = lib.mkIf cfg.enable {
    services.greetd = let
      session = {
        command = "${getExe pkgs.hyprland}";
        user = "alexander";
      };
    in {
      enable = true;
      settings = {
        terminal.vt = 1;
        default_session = session;
        initial_session = session;
      };
    };
    security.pam.services = {
      greetd.enableGnomeKeyring = true;
    };
  };
}
