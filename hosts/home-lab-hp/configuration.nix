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
    ./hardware-configuration.nix
    #(import ../modules/nixos/disko.nix {device = "/dev/nvme0n1";})
    ./nextcloud-vm.nix
  ];

  hardware.pulseaudio.enable = lib.mkForce true;

  modules = {
    impermanence.enable = false;
    zerotier = {
      enable = true;
      port = 9995;
    };
    plymouth.enable = true;
    stylix = {
      enable = true;
      flavour = "mocha";
    };
  };

  security.sudo.enable = true;

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

  time.timeZone = lib.mkDefault "Europe/Moscow";
  i18n = {
    defaultLocale = lib.mkDefault "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ru_RU.UTF-8/UTF-8"
    ];
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      # Forbid root login through SSH.
      PermitRootLogin = "yes";
      # Use keys only. Remove if you want to SSH using password (not recommended)
      PasswordAuthentication = false;
    };
    ports = [22];
  };
  users.users.alexander.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC+q2959wpotECucVJLyqEtur8iouzs7uUR0m70wyOlO4wFsTKLuedoFfOlIxBD/LLUv6zDyPz1vFV8PTKi051UnWDzwrz5GeK9GOZ/5ydZlFQL9EVmvS3NxJGUEH9JTbJnJtJ/0vP5vereE5GHQF1bcWChhbpATUGmwHGGzux+AxkcdifrbNP7tElTw0ePzNyaGinWSYAin+dRsTC0rqER0QXj3LR0SuyvxpcZPwo5i6dlwGdmhtndCIYtIwwYl3l/MLf0nvwb1sxJiAGV791BlatLQiL3weAnlrWGkkjWti8y44I9CdHW9unbiScTVdz/sqr1KBzpR4bb/c+futRAHqdp7Hg/8KtUhMH78W/8bsloGA8dkfpv0vYwT9geOY1QmYegwcAqGHIIFauxJHKMgGRrcDNcZhzP5vOogjYIZPqzbpq6IZaOPL/f48G/npCptmqiN9xt31gc0IGk6VfqM1Myyru8u0A1rhKKz3sHhvv/whtFkSt6onKVZ4xcOjk= alex.rom23@mail.ru"
  "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCWsvBU4c3LS+93FcCt5S10El1N8UET7KaZ/K6/3kJIvwsj2A5rOJ7jU88vvFt4DXhYS/OluX5GImwm5qSBvWViTXJMjp1y/L41PjZPga2+pgfJ1+aWXzx1HkGzy/HRo5gubShWbcYgnoeJa8YOOlIcTAqd3RyjHfQbfTpgp6mikB0DcC/0TKD71e/ez/qgnVe+me/bEnHzaDHASk3/2bktNxshNwmyWG6h8P68YnBVZmPNoIl8HMJx45OtBDoDwry0JLa4bh4DRARwW7v7nuA47ZnHIL9bylUlPfuipmzL6LKmUNNKiYia3bR7eRFoAAtrCNnCObnO1vy5lnbcnPEy4hmOc+6Q2p8UEoLGJ/lG74ozXtZ4/c/bTmGe4C51rDDjgMEWTIdX/JavnkIuQr3g3ybU0hK1qF2quaVfCtamJxFcrFej5sNgLf7FGpggemU2XAkXWrAyduj5t9X6ALxnu0UkNtSNr0aFs7y1a8lKq2Wdz+eQORQLrmIHM7zf7p8= alex.rom23@mail.ru"
  ];

  networking.extraHosts = "185.180.231.81 frp-remote-server";
  boot.kernelPackages = pkgs.linuxPackages_6_9;

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
  system.stateVersion = "24.05"; # Did you read the comment?
}
