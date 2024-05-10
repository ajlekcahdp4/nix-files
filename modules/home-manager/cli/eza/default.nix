{
  lib,
  config,
  ...
}: let
  cfg = config.modules.eza;
in {
  options = {
    modules.eza.enable = lib.mkEnableOption "enable eza setup";
  };
  config = lib.mkIf cfg.enable {
    programs.eza = {
      enable = true;
      git = true;
      icons = lib.mkDefault true;

      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
    };
  };
}
