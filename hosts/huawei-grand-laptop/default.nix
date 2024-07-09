{lib, ...}:
lib.mkHostInfo {
  system = "x86_64-linux";
  hostname = "huawei-grand-laptop";
  nixosModules = [./configuration.nix];
  homeModules = [./home.nix];
}
