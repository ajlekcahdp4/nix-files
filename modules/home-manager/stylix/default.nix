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
      autoEnable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      cursor = {
        package = pkgs.catppuccin-cursors.mochaDark;
        name = "Catppuccin-Mocha-Dark-Cursors";
      };
    };
  };
}
