{lib, ...}:
lib.mkHostInfo {
  system = "x86_64-linux";
  hostname = "home-lab-hp";
  nixosModules = [./configuration.nix];
  homeModules = [./home.nix];
}
