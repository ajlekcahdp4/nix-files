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
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    outputs.homeManagerModules.cli
    outputs.homeManagerModules.desktop
  ];

  modules = {
    stylix = {
      enable = true;
      enableWallpapers = false;
    };
    eza.enable = true;
    fzf.enable = true;
    direnv.enable = true;
    nixvim.enable = true;
    zsh.enable = true;
    zellij.enable = true;
    gnome.enable = false;
    wezterm.enable = true;
    atuin.enable = true;
    starship.enable = true;
    firefox.enable = true;
  };

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
    packages = [
      inputs.yandex-browser.packages.x86_64-linux.yandex-browser-stable
    ];
  };

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
