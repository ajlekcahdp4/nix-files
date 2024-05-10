{
  lib,
  config,
  ...
}: let
  cfg = config.modules.fzf;
in {
  options = {
    modules.fzf.enable = lib.mkEnableOption "enable fzf";
  };

  config = lib.mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
