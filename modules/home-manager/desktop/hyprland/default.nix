{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.hyprland;
in {
  options.modules.hyprland.enable = lib.mkEnableOption "enable hyprland";
  config = lib.mkIf cfg.enable {
    services.hyprsunset.enable = true;
    wayland.windowManager.hyprland = {
      enable = true;
      systemd = {
        enable = false;
        variables = ["--all"];
      };
      settings = {
        "$mainMod" = "SUPER";
        "$term" = "ghostty";
        "$editor" = "vim";
        exec-once = [
          "waybar"
          "hyprlock"
          "hyprpaper"
        ];
        env = [
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XDG_SESSION_DESKTOP,Hyprland"
          "GDK_BACKEND,wayland,x11,*"
          "NIXOS_OZONE_WL,1"
          "ELECTRON_OZONE_PLATFORM_HINT,auto"
          "MOZ_ENABLE_WAYLAND,1"
        ];

        input = {
          kb_layout = "us,ru";
          kb_variant = ",";
          kb_options = "grp:alt_shift_toggle";
          repeat_delay = 300; # or 212
          repeat_rate = 30;

          follow_mouse = 1;

          touchpad.natural_scroll = true;

          tablet.output = "current";

          sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
          force_no_accel = true;
        };
        misc = {
          mouse_move_focuses_monitor = true;
        };
        binds = {
          workspace_back_and_forth = true;
          allow_workspace_cycles = true;
        };
        bind = [
          "$mainMod, return, exec, ghostty"
          "$mainMod, R, exec, rofi -show drun"
          "$mainMod, E, exec, nautilus"
          "$mainMod, P, exec, nwg-displays"

          # Screenshots
          ", PRINT, exec, hyprshot -m region -o ~/Pictures/ScreenshotQs"
          "shift, PRINT, exec, hyprshot -m window -o ~/Pictures/Screenshots"

          # General
          "$mainMod, C, killactive"
          "$mainMod, delete, exit"
          "$SUPER_SHIFT, l, exec, hyprlock"

          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
          # Switch workspaces relative to the active workspace with mainMod + CTRL + [←→]
          "$mainMod CTRL, right, workspace, r+1"
          "$mainMod CTRL, left, workspace, r-1"
          "$mainMod CTRL, l, workspace, r+1"
          "$mainMod CTRL, h, workspace, r-1"
          # move to the first empty workspace instantly with mainMod + CTRL + [↓]
          "$mainMod CTRL, down, workspace, empty"
          "$mainMod, Tab, workspace, +1"
          "$mainMod SHIFT, Tab, workspace, +1"
          # Move active window to a relative workspace with mainMod + CTRL + ALT + [←→]
          "$mainMod CTRL ALT, right, movetoworkspace, r+1"
          "$mainMod CTRL ALT, left, movetoworkspace, r-1"
          "$mainMod CTRL ALT, l, movetoworkspace, r+1"
          "$mainMod CTRL ALT, h, movetoworkspace, r-1"
          # volume control
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          #brightness control
          ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
          ",XF86MonBrightnessUp, exec, brightnessctl s +10%"
          # Night Mode (lower value means warmer temp)
          "$mainMod, F9, exec, hyprsunset --temperature 3500" # good values: 3500, 3000, 2500
          "$mainMod, F10, exec, pkill hyprsunset"
          # ALT-TABbing workspaces
          "ALT, Tab, workspace, previous"
        ];
        general = {
          gaps_in = 4;
          gaps_out = 9;
          border_size = 2;
          resize_on_border = true;
          layout = "dwindle"; # dwindle or master
        };
        decoration = {
          shadow.enabled = false;
          rounding = 10;
          dim_special = 0.3;
          blur = {
            enabled = true;
            special = true;
            size = 6;
            passes = 2;
            new_optimizations = true;
            ignore_opacity = true;
            xray = false;
          };
        };
        gestures = {
          workspace_swipe = true;
          workspace_swipe_fingers = 2;
        };
      };
      extraConfig = ''
        monitor=,preferred,auto,1
        source = ~/.config/hypr/monitors.conf
      '';
    };
    programs.wlogout.enable = true;
  };
}
