{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.stylix;
in {
  options = {
    modules.stylix.enable = lib.mkEnableOption "enable stylix setup";
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      image = pkgs.fetchurl {
        url = "https://w.wallhaven.cc/full/2y/wallhaven-2y2wg6.png";
        sha256 = "sha256-nFoNfk7Y/CGKWtscOE5GOxshI5eFmppWvhxHzOJ6mCA=";
      };

      autoEnable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      targets = {
        gnome.enable = true;
        nixvim.enable = true;
        nixvim.transparent_bg.main = true;
        nixvim.transparent_bg.sign_column = true;
        firefox.enable = true;
        bat.enable = true;
        zellij.enable = true;
        btop.enable = true;
      };
      opacity = let
        alpha = 0.95;
      in {
        terminal = alpha;
        popups = alpha;
        desktop = alpha;
        applications = alpha;
      };
      cursor = {
        package = pkgs.catppuccin-cursors.mochaDark;
        name = "Catppuccin-Mocha-Dark-Cursors";
      };

      fonts = {
        sizes = let
          fontSize = 13;
        in {
          terminal = fontSize;
          popups = fontSize;
          desktop = fontSize;
          applications = fontSize;
        };
      };
    };
  };
}
