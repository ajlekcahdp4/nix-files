{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [inputs.stylix.nixosModules.stylix];

  stylix = {
    autoEnable = true;
    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/2y/wallhaven-2y2wg6.png";
      sha256 = "sha256-nFoNfk7Y/CGKWtscOE5GOxshI5eFmppWvhxHzOJ6mCA=";
    };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  };
}
