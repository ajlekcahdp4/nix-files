{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [inputs.stylix.nixosModules.stylix];
  stylix = {
    autoEnable = lib.mkOverride 75 true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

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
