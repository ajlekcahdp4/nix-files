{
  lib,
  config,
  ...
}: let
  cfg = config.modules.wezterm;
in {
  options = {
    modules.wezterm.enable = lib.mkEnableOption "enable wezterm";
  };

  config = lib.mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      extraConfig = ''
        return {
          color_scheme = "Catppuccin Mocha (Gogh)"
        }
      '';
    };
  };
}
