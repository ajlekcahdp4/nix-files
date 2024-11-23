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
      icons = lib.mkDefault "auto";
      enableBashIntegration = true;
      enableZshIntegration = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
    };
  };
}
