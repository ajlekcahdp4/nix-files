{
  inputs,
  outputs,
  lib,
  pkgs,
  ...
}: {
  imports = [];

  home-modules.stylix = {
    enable = true;
    flavour = "mocha";
  };
  modules = {
    eza.enable = true;
    fzf.enable = lib.mkDefault false;
    direnv.enable = lib.mkDefault false;
    nixvim.enable = true;
    vscode.enable = true;
    zsh.enable = true;
    zellij.enable = true;
    gnome.enable = lib.mkDefault false;
    wezterm.enable = false;
    alacritty.enable = true;
    atuin.enable = true;
    starship.enable = true;
    firefox.enable = lib.mkDefault false;
  };

  programs.home-manager.enable = true;

  programs.btop.enable = true;

  programs.bat.enable = true;
  programs.ripgrep.enable = true;
  programs.thunderbird = {
    enable = true;
    profiles.default.isDefault = true;
  };

  home.packages = with pkgs; [
    nerd-fonts.noto
    nekoray
    xclip
    hiddify-app
    jq
    yq
    pandoc
  ];
  home.stateVersion = "23.11";
}
