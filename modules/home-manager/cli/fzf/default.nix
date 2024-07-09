{
  outputs,
  lib,
  config,
  extraConfig,
  ...
}: let
  cfg = config.modules.fzf;
in {
  options = {
    modules.fzf.enable = lib.mkEnableOption "Enable fzf";
    # modules = outputs.lib.mkForUsers ["alexander" "alexey"] {
    #   name = "fzf";
    #   option = lib.mkEnableOption "Enable fzf";
    # };
  };

  config = lib.mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
