{
  lib,
  config,
  ...
}: let
  cfg = config.modules.direnv;
in {
  options = {
    modules.direnv.enable = lib.mkEnableOption "enable direnv";
  };

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
