# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{pkgs, ...}: let
  inherit (pkgs) callPackage;
in {
  zerotier-systemd-manager = callPackage ./zerotier-systemd-manager.nix {};
}
