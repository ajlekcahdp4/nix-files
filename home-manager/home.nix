# This is your home-manager configuration file
# If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ../modules/home-manager/nixvim
    ../modules/home-manager/eza
    ../modules/home-manager/direnv
    ../modules/home-manager/wezterm
    ../modules/home-manager/starship
    ../modules/home-manager/atuin
    ../modules/home-manager/fzf
    ../modules/home-manager/zellij
    ../modules/home-manager/zsh
    ../modules/home-manager/firefox
    ../modules/home-manager/gnome
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "alexander";
    homeDirectory = "/home/alexander";
  };

  # home.packages = with pkgs; [ galaxy-buds-client ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "Alexander Romanov";
    userEmail = "alex.rom23@mail.ru";
  };
  programs.starship.enable = true;

  programs.btop.enable = true;

  programs.bat.enable = true;
  programs.ripgrep.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
