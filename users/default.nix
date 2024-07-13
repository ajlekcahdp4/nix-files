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
    addHomePackages = {pkgs, ...}: {
      home.packages = [
        pkgs.epsonscan2
      ];
    };
  in
    mkUser {
      name = "alexander";
      normalUser = true;
      groups = ["wheel" "sound" "audio" "video" "scanner" "lp"];
      optionalGroups = [
        "docker"
        "networkmanager"
      ];
      homeModules = [setUserOptionsModule gitSetupModule addHomePackages];
    };

  alexey = let
    addUserPackages = {
      inputs,
      pkgs,
      ...
    }: {
      home.packages = [
        inputs.yandex-browser.packages.x86_64-linux.yandex-browser-stable
        pkgs.gnome.aisleriot
      ];
    };
    setUserOptionsModule = {
      home-modules.stylix.enable = true;
      home-modules.stylix.flavour = "latte";
    };
    setLargeFonts = {
      config,
      lib,
      ...
    }: let
      cfg = config.home-modules.stylix;
    in {
      stylix.fonts.sizes = lib.mkIf cfg.enable {
        applications = 15;
        desktop = 15;
        popups = 15;
      };
    };

    setRuLocale = {
      home.language.base = "ru_RU.UTF-8";
      programs.plasma.configFile = {
        plasma-localerc.Formats."LANG" = "ru_RU.UTF-8";
      };
    };
  in
    mkUser {
      name = "alexey";
      normalUser = true;
      groups = ["audio" "video" "scanner" "lp"];
      optionalGroups = [
        "networkmanager"
      ];
      homeModules = [setUserOptionsModule addUserPackages setLargeFonts setRuLocale];
    };
}
