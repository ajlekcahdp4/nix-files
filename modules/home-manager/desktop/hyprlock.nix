{
  lib,
  config,
  ...
}: let
  cfg = config.modules.hyprlock;
in {
  options.modules.hyprlock.enable = lib.mkEnableOption "enable hyprlock";
  config = lib.mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          hide_cursor = true;
        };

        input-field = {
          monitor = "";
          size = "250, 50";
          outline_thickness = 3;
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          fail_transition = 300;
          fade_on_empty = false;
          placeholder_text = "Password...";
          dots_size = 0.2;
          dots_spacing = 0.64;
          dots_center = true;
          position = "0, 140";
          halign = "center";
          valign = "bottom";
        };

        label = [
          {
            monitor = "";
            # text = "cmd[update:1000] echo \"<b><big> $(date +\"%H:%M:%S\") </big></b>\"";
            text = "$TIME";
            font_size = 64;
            font_family = "JetBrains Mono Nerd Font 10";
            color = "rgb(198, 160, 246)";
            position = "0, 16";
            valign = "center";
            halign = "center";
          }
          {
            monitor = "";
            text = "Greetings, my leige <span text_transform=\"capitalize\" size=\"larger\">$USER!</span>";
            color = "rgb(198, 160, 246)";
            font_size = 20;
            font_family = "JetBrains Mono Nerd Font 10";
            position = "0, 100";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = "Current Layout : $LAYOUT";
            color = "rgb(198, 160, 246)";
            font_size = 14;
            font_family = "JetBrains Mono Nerd Font 10";
            position = "0, 20";
            halign = "center";
            valign = "bottom";
          }
          /*
             {
            monitor = "";
            text = "Enter your password to unlock.";
            color = "rgb(198, 160, 246)";
            font_size = 14;
            font_family = "JetBrains Mono Nerd Font 10";
            position = "0, 60";
            halign = "center";
            valign = "bottom";
          }
          */
        ];
      };
    };
  };
}
