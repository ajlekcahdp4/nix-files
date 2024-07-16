# Edit this configuration file to define what should be installed on
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common
    outputs.nixosModules
    ./hardware-configuration.nix
    #(import ../modules/nixos/disko.nix {device = "/dev/nvme0n1";})
  ];

  hardware.pulseaudio.enable = lib.mkForce false;
  sound.enable = lib.mkForce false;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
    pulse.enable = true;
  };

  modules = {
    impermanence.enable = false;
    zerotier.enable = true;
    plymouth.enable = true;
    stylix = {
      enable = true;
      flavour = "latte";
      wallpaper = ./wallpaper.jpg;
    };
  };
  security.sudo.enable = true;
  security.pam.services.sddm.enableKwallet = false;

  environment.etc = {
    "xdg/kwalletrc" = {
      text = ''
        [Wallet]
        Enabled=false
      '';
    };
  };

  services.printing.enable = true;
  services.printing.browsing = true;
  services.printing.drivers = with pkgs; [
    epson_201207w
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };
  networking.hostName = "laptop";

  time.timeZone = lib.mkDefault "Europe/Moscow";
  i18n = {
    defaultLocale = lib.mkDefault "ru_RU.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ru_RU.UTF-8/UTF-8"
    ];
  };

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "plasma";
  services.desktopManager.plasma6 = {
    enable = true;
    enableQt5Integration = true;
  };
  environment.systemPackages = with pkgs; [kdePackages.kde-gtk-config];
  services.dbus.enable = true;

  services.xserver = {
    xkb.layout = "us,ru";
    xkb.variant = ",";
    xkb.options = "grp:alt_shift_toggle";
  };

  services.openssh = {
    enable = true;
    settings = {
      # Forbid root login through SSH.
      PermitRootLogin = "no";
      # Use keys only. Remove if you want to SSH using password (not recommended)
      PasswordAuthentication = false;
    };
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}
