{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.home-modules.stylix;
  defaultWallpaper = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/2y/wallhaven-2y2wg6.png";
    sha256 = "sha256-nFoNfk7Y/CGKWtscOE5GOxshI5eFmppWvhxHzOJ6mCA=";
  };
in {
  options = {
    home-modules.stylix = {
      enable = lib.mkEnableOption "enable stylix setup";
      wallpaper = lib.mkOption {
        description = "Path of the image to set as a wallpaper";
        default = defaultWallpaper;
      };
      flavour = lib.mkOption {
        description = "Catppuccin flavour";
        type = lib.types.enum ["mocha" "latte"];
        default = "mocha";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      image = cfg.wallpaper;
      targets = {
        gnome.enable = true;
        gtk.enable = true;
        qt.platform = "qtct";
        nixvim.enable = true;
        nixvim.transparentBackground.main = true;
        nixvim.transparentBackground.signColumn = true;
        firefox = {
          enable = true;
          profileNames = ["alexander"];
        };
        bat.enable = true;
        zellij.enable = true;
        btop.enable = true;
        wezterm.enable = true;
        alacritty.enable = true;
        kitty.enable = true;
        kde.enable = false;
        vscode = {
          profileNames = ["default"];
        };
      };
      opacity = let
        alpha = 0.95;
      in {
        terminal = alpha;
        popups = alpha;
        desktop = alpha;
        applications = alpha;
      };
      autoEnable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-${cfg.flavour}.yaml";
      cursor = {
        package = pkgs.capitaine-cursors;
        name = "capitaine-cursors";
        size = 10;
      };
    };
  };
}
