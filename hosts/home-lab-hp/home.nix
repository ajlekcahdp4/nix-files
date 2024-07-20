{
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}: {
  imports = [];

  home-modules.stylix = {
    enable = lib.mkDefault true;
    flavour = lib.mkDefault "mocha";
  };
  modules = {
    eza.enable = true;
    fzf.enable = true;
    nixvim.enable = true;
    zsh.enable = true;
    zellij.enable = true;
    gnome.enable = lib.mkDefault true;
    wezterm.enable = true;
    atuin.enable = true;
    starship.enable = true;
    firefox.enable = lib.mkDefault true;
  };

  programs.home-manager.enable = true;

  programs.btop.enable = true;
  programs.bat.enable = true;
  programs.ripgrep.enable = true;

  home.stateVersion = "24.05";
}
