{
  inputs,
  outputs,
  lib,
  ...
}: {
  imports = [];

  modules = {
    stylix = {
      enable = lib.mkDefault true;
      flavour = lib.mkDefault "latte";
    };
    eza.enable = true;
    fzf.enable = false;
    direnv.enable = lib.mkDefault false;
    nixvim.enable = true;
    zsh.enable = true;
    zellij.enable = true;
    gnome.enable = lib.mkDefault false;
    wezterm.enable = true;
    atuin.enable = true;
    starship.enable = true;
    firefox.enable = lib.mkDefault false;
  };

  programs.home-manager.enable = true;

  programs.btop.enable = true;

  programs.bat.enable = true;
  programs.ripgrep.enable = true;
  home.stateVersion = "23.11";
}
