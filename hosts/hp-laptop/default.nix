{lib, ...}:
lib.mkHostInfo {
  system = "x86_64-linux";
  hostname = "laptop";
  nixosModules = [./configuration.nix];
  homeModules = [./home.nix];
}
