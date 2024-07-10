{
  description = "Alexander's nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs-unstable.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs-unstable.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };
    
    yandex-browser = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:miuirussia/yandex-browser.nix";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "x86_64-linux"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
    lib = import ./lib {inherit inputs outputs;};
    users = import ./users {inherit lib;};
    hosts = import ./hosts {inherit lib;};
  in {
    inherit lib;
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      laptop = lib.mkHostSystem {
        users = {inherit (users) alexander;};
        hostInfo = hosts.laptop;
      };

      huawei-grand-laptop = lib.mkHostSystem {
        users = {inherit (users) alexander;};
        hostInfo = hosts.huawei-grand-laptop;
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = let
      setNixModule = {pkgs, ...}: {nix.package = pkgs.nix;};
    in {
      "alexander@laptop" = lib.mkHomeConfig {
        user = users.alexander;
        host = hosts.laptop;
        modules = [setNixModule];
      };

      "alexander@huawei-grand-laptop" = lib.mkHomeConfig {
        user = users.alexander;
        host = hosts.huawei-grand-laptop;
        modules = [setNixModule];
      };

      "alexey@huawei-grand-laptop" = lib.mkHomeConfig {
        user = users.alexey;
        host = hosts.huawei-grand-laptop;
        modules = [setNixModule];
      };
    };
  };
}
