# Custom packages, that can be defined similarly to ones from nixpkgs
{pkgs, ...}: let
  inherit (pkgs) callPackage;
in {
  zerotier-systemd-manager = callPackage ./zerotier-systemd-manager.nix {};
}
