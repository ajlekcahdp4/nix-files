{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [inputs.stylix.nixosModules.stylix];
  stylix = {
    image = ./wallpaper.jpg;
    autoEnable = lib.mkOverride 75 true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";
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
}
