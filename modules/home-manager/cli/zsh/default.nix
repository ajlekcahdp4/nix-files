{
  lib,
  config,
  ...
}: let
  cfg = config.modules.zsh;
in {
  options = {
    modules.zsh.enable = lib.mkEnableOption "enable zsh";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      historySubstringSearch.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = ["git"];
      };
      autosuggestion.enable = true;
    };
  };
}
