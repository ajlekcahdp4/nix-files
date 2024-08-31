{
  lib,
  config,
  ...
}: let
  cfg = config.modules.alacritty;
in {
  options = {
    modules.alacritty.enable = lib.mkEnableOption "enable alacritty";
  };

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          padding.x = 0;
          padding.y = 0;
          dynamic_title = false;
          decorations = "full";
          decorations_theme_variant = "Dark";
        };
      };
    };
  };
}
