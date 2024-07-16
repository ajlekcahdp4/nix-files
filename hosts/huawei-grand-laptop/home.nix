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
    flavour = lib.mkDefault "latte";
    wallpaper = ./wallpaper.jpg;
  };
  modules = {
    eza.enable = true;
    fzf.enable = false;
    direnv.enable = lib.mkDefault false;
    nixvim.enable = true;
    zsh.enable = true;
    zellij.enable = true;
    gnome.enable = lib.mkDefault false;
    plasma.enable = lib.mkDefault true;
    wezterm.enable = true;
    atuin.enable = true;
    starship.enable = true;
    firefox.enable = lib.mkDefault false;
  };

  # alsa fixes yoinked from https://github.com/KreconyMakaron/dotfiles
  home.packages = with pkgs; [
    sof-firmware
    alsa-utils
  ];
  systemd.user.services.alsa-fixes = {
    Unit.Description = "Enable Speakers";
    Service = {
      RemainAfterExit = true;
      Type = "oneshot";
      ExecStart = [
        "${lib.getExe' pkgs.alsa-utils "amixer"} -c 0 cset 'numid=69' 1"
        "${lib.getExe' pkgs.alsa-utils "amixer"} -c 0 cset 'numid=70' 1"
        "${lib.getExe' pkgs.alsa-utils "amixer"} -c 0 cset 'numid=71' 1"
        "${lib.getExe' pkgs.alsa-utils "amixer"} -c 0 cset 'numid=72' 1"
      ];
    };
    Install.WantedBy = ["default.target"];
  };

  programs.home-manager.enable = true;

  programs.btop.enable = true;

  programs.bat.enable = true;
  programs.ripgrep.enable = true;
  home.stateVersion = "23.11";
}
