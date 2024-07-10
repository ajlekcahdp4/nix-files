{lib, ...}: let
  inherit (lib) mkUser;
in {
  alexander = let
    setUserOptionsModule = {
      modules.direnv.enable = true;
      modules.gnome.enable = true;
      modules.firefox.enable = true;
      home-modules.stylix.enable = true;
      home-modules.stylix.flavour = "mocha";
    };
    gitSetupModule = {
      programs.git = {
        enable = true;
        userName = "Alexander Romanov";
        userEmail = "alex.rom23@mail.ru";
      };
    };
  in
    mkUser {
      name = "alexander";
      normalUser = true;
      groups = ["wheel" "audio" "video"];
      optionalGroups = [
        "docker"
        "networkmanager"
      ];
      homeModules = [setUserOptionsModule gitSetupModule];
    };

  alexey = let
    addUserPackages = {inputs, ...}: {
      home.packages = [
        inputs.yandex-browser.packages.x86_64-linux.yandex-browser-stable
      ];
    };
    setUserOptionsModule = {
      home-modules.stylix.enable = true;
      home-modules.stylix.flavour = "latte";
    };
  in
    mkUser {
      name = "alexey";
      normalUser = true;
      groups = ["wheel" "audio" "video"];
      optionalGroups = [
        "docker"
        "networkmanager"
      ];
      homeModules = [setUserOptionsModule addUserPackages];
    };
}
