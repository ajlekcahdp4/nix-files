{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  services.pulseaudio.enable = lib.mkDefault true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);
  services.automatic-timezoned.enable = false;

  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = ["/etc/nix/path"];
  nix.package = pkgs.nixVersions.nix_2_29;
  environment.variables.EDITOR = "vim";
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  # FIXME: Add the rest of your current configuration
  programs.zsh.enable = true;
  programs.ssh.startAgent = true;
  users.defaultUserShell = pkgs.zsh;

  networking.networkmanager.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  services.libinput.touchpad.tapping = true;
}
