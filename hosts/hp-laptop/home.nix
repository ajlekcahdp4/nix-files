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
    waybar.enable = true;
    hyprland.enable = true;
    hyprlock.enable = true;
    hyprpaper.enable = true;
    hypridle.enable = true;
    swaync.enable = true;
    rofi.enable = true;
  };

  programs.home-manager.enable = true;

  programs.btop.enable = true;

  programs.bat.enable = true;
  programs.ripgrep.enable = true;
  programs.thunderbird = {
    enable = true;
    profiles.default.isDefault = true;
  };
  programs.cava.enable = true;
  nixpkgs.config.allowUnfree = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-hyprland xdg-desktop-portal-gtk];
    xdgOpenUsePortal = true;
  };
  home.packages = with pkgs; [
    nerd-fonts.noto
    nekoray
    nwg-displays
    xclip
    hiddify-app
    jq
    yq
    pandoc
    binsider
    nautilus
    # Hyprland stuff
    poweralertd
    hyprpicker
    hyprsunset
    cliphist
    grimblast
    swappy
    libnotify
    brightnessctl
    networkmanagerapplet
    pamixer
    pavucontrol
    playerctl
    waybar
    hyprshot
    overskride
    wtype
    wl-clipboard
    xdotool
    yad
  ];
  services.amberol.enable = true;
  home.stateVersion = "23.11";
}
