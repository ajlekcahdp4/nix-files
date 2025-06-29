{
  lib,
  config,
  ...
}: let
  cfg = config.modules.zellij;
in {
  options = {
    modules.zellij.enable = lib.mkEnableOption "enable Zellij";
  };

  config = lib.mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      settings = {
        default_layout = "compact";
        show_startup_tips = false;
        pane_frames = false;
        keybinds.normal = {
          unbind = ["Ctrl q" "Ctrl b"];
        };
      };
    };
  };
}
