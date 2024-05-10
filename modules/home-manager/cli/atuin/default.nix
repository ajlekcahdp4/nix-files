{
  lib,
  config,
  ...
}: let
  cfg = config.modules.atuin;
in {
  options = {
    modules.atuin.enable = lib.mkEnableOption "enable atuin";
  };

  config = lib.mkIf cfg.enable {
    programs.atuin = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      settings = {
        auto_sync = true;
        sync_frequency = "5m";
        filter_mode = "host";
        filter_mode_shell_up_key_binding = "session";
      };
    };
  };
}
