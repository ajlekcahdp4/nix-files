{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.ghostty = {
    enable = true;
    settings = {
      confirm-close-surface = false;
    };
  };
}
