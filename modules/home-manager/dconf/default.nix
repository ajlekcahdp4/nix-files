{...}: {
  dconf.settings = {
    "org/gnome/desktop/peripherals/touchpad" = {
      accel-profile = "default";
      click-method = "fingers";
      disable-while-typing = true;
      edge-scrolling-enabled = false;
      left-handed = "mouse";
      middle-click-emulation = false;
      natural-scroll = true;
      send-events = "enabled";
      speed = 0.0;
      tap-and-drag = true;
      tap-and-drag-lock = false;
      tap-button-map = "default";
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Alt><Ctrl>t";
      command = "wezterm";
      name = "open wezterm";
    };
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
      power-button-action = "interactive";
    };
  };
}
