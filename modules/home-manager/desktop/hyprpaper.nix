{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.hyprpaper;
in {
  options.modules.hyprpaper.enable = lib.mkEnableOption "enable hyprpaper";
  config = lib.mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        splash = false;
        splash_offset = 2.0;
        ipc = "on";
      };
    };

    home.packages = with pkgs; [hyprpaper];
  };
}
