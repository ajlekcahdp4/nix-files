{lib, ...}: {
  # https://github.com/Electrostasy/dots/blob/c62895040a8474bba8c4d48828665cfc1791c711/profiles/system/gnome/default.nix#L123-L287
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

    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
      power-button-action = "interactive";
    };
  };
}
