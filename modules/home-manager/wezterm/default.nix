{...}: {
  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    extraConfig = ''
      return {
        color_scheme = "Catppuccin Mocha (Gogh)"
      }
    '';
  };
}
