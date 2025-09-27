{
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.plasma;
in {
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
  ];

  options.modules.plasma.enable = lib.mkEnableOption "Enable plasma-manager";

  config = lib.mkIf cfg.enable {
    programs.plasma = {
      enable = true;
    };
  };
}
