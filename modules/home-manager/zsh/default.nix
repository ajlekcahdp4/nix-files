{...}: {
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
}
