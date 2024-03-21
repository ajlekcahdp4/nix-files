{config, pkgs, ...}:
{
  home.username = "alexander";
  home.homeDirectory = "/home/alexander";
  home.stateVersion = "23.11";  
  home.packages = with pkgs; [
    neofetch
    ripgrep
    eza
    zip
    tree
    btop
    git
    vim
    helix
  ];
  
  programs.git = {
    enable = true;
    userName = "Alexander Romanov";
    userEmail = "alex.rom23@mail.ru";
  };

  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [Vundle-vim];
    settings = {
      tabstop = 2;
      shiftwidth = 2;
      expandtab = false;
      smartcase = true;
      number = true;
    };
  };

  programs.home-manager.enable = true;
}
