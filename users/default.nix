{lib, ...}: let
  inherit (lib) mkUser;
in {
  alexander = let
    setUserOptionsModule = {
      modules.direnv.enable = true;
      modules.gnome.enable = true;
      modules.firefox.enable = true;
      modules.stylix.flavour = "latte";
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

  alexey = mkUser {
    name = "alexey";
    normalUser = true;
    groups = ["audio" "video"];
    optionalGroups = [
      "docker"
      "networkmanager"
    ];
    homeModules = [];
  };
}
