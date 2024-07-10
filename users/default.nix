{lib,  ...}: let
  inherit (lib) mkUser;
in {
  alexander = let
    setUserOptionsModule = {
      modules.direnv.enable = true;
      modules.gnome.enable = true;
      modules.firefox.enable = true;
      modules.stylix.enable = false;
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
      homeModules = [setUserOptionsModule gitSetupModule ];
    };

  alexey = let
    addUserPackages = {inputs, ...}:{
      home.packages = [
        inputs.yandex-browser.packages.x86_64-linux.yandex-browser-stable];
    };
    setUserOptionsModule = {
      modules.stylix.enable = false;
      modules.stylix.flavour = "mocha";
    };
  in mkUser {
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
