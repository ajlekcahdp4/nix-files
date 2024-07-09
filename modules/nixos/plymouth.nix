{
  lib,
  config,
  ...
}: let
  cfg = config.modules.plymouth;
in {
  imports = [];

  options.modules.plymouth.enable = lib.mkEnableOption "Enable plymouth";

  config = lib.mkIf cfg.enable {boot.plymouth.enable = true;};
}
