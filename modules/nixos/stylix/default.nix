{
  pkgs,
  config,
  inputs,
  lib,
  sgdgfgd,
  ...
}: let
  cfg = config.modules.stylix;
  defaultWallpaper = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/2y/wallhaven-2y2wg6.png";
    sha256 = "sha256-nFoNfk7Y/CGKWtscOE5GOxshI5eFmppWvhxHzOJ6mCA=";
  };
in {
  imports = [inputs.stylix.nixosModules.stylix];
  options.modules.stylix = {
    enable = lib.mkEnableOption "Enable stylix setup";
    flavour = lib.mkOption {
      description = "Catppuccin flavour";
      type = lib.types.enum ["mocha" "latte"];
      default = "mocha";
    };
    wallpaper = lib.mkOption {
      description = "Image to set as a wallpaper";
      type = with lib.types; coercedTo package toString path;
      default = defaultWallpaper;
    };
  };
  config = lib.mkIf cfg.enable {
    stylix = {
      autoEnable = lib.mkOverride 75 true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-${cfg.flavour}.yaml";
      targets = {
        plymouth.enable = true;
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
    };
  };
}
