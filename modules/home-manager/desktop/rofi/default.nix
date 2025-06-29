{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.rofi;
in {
  options.modules.rofi.enable = lib.mkEnableOption "enable rofi";
  config = lib.mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      theme = let
        inherit (config.lib.formats.rasi) mkLiteral;
      in {
        # rounded theme for rofi
        # Author: Newman Sanchez (https://github.com/newmanls)
        "*" = {
          bg0 = mkLiteral "#2E3440F2";
          bg1 = mkLiteral "#3B4252";
          bg2 = mkLiteral "#4C566A80";
          bg3 = mkLiteral "#88C0D0F2";
          fg0 = mkLiteral "#D8DEE9";
          fg1 = mkLiteral "#ECEFF4";
          fg2 = mkLiteral "#D8DEE9";
          fg3 = mkLiteral "#4C566A";

          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@fg0";

          margin = mkLiteral "0px";
          padding = mkLiteral "0px";
          spacing = mkLiteral "0px";
        };

        "window" = {
          location = mkLiteral "north";
          y-offset = mkLiteral "calc(50% - 176px)";
          width = mkLiteral "480";
          border-radius = mkLiteral "24px";

          background-color = mkLiteral "@bg0";
        };

        "mainbox" = {
          padding = mkLiteral "12px";
        };

        "inputbar" = {
          background-color = mkLiteral "@bg1";
          border-color = mkLiteral "@bg3";

          border = mkLiteral "2px";
          border-radius = mkLiteral "16px";

          padding = mkLiteral "8px 16px";
          spacing = mkLiteral "8px";
          children = mkLiteral "[ prompt, entry ]";
        };

        "prompt" = {
          text-color = mkLiteral "@fg2";
        };

        "entry" = {
          placeholder = "Search";
          placeholder-color = mkLiteral "@fg3";
        };

        "message" = {
          margin = mkLiteral "12px 0 0";
          border-radius = mkLiteral "16px";
          border-color = mkLiteral "@bg2";
          background-color = mkLiteral "@bg2";
        };

        "textbox" = {
          padding = mkLiteral "8px 24px";
        };

        "listview" = {
          background-color = mkLiteral "transparent";

          margin = mkLiteral "12px 0 0";
          lines = 8;
          columns = 1;

          fixed-height = false;
        };

        "element" = {
          padding = mkLiteral "8px 16px";
          spacing = mkLiteral "8px";
          border-radius = mkLiteral "16px";
        };

        "element normal active" = {
          text-color = mkLiteral "@bg3";
        };

        "element alternate active" = {
          text-color = mkLiteral "@bg3";
        };

        "element selected normal, element selected active" = {
          background-color = mkLiteral "@bg3";
        };

        "element selected" = {
          text-color = mkLiteral "@bg1";
        };
        "element-icon" = {
          size = mkLiteral "1em";
          vertical-align = mkLiteral "0.5";
        };

        "element-text" = {
          text-color = mkLiteral "inherit";
        };
      };
      extraConfig = {
        modi = ["run" "drun" "emoji"];
        show-icons = true;
        terminal = "kitty";
        drun-display-format = "{icon} {name}";
        location = 0;
        disable-history = false;
        hide-scrollbar = true;
        display-drun = "   Apps ";
        display-run = "   Run ";
        display-window = " 󰕰  Window";
        display-Network = " 󰤨  Network";
        display-emoji = " Emojis";
        sidebar-mode = true;
      };
      plugins = with pkgs; [
        rofi-emoji-wayland # https://github.com/Mange/rofi-emoji 🤯
      ];
    };
  };
}
