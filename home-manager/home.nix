# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    # For NixOS
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  programs.nixvim = {
    enable = true;
    enableMan = true;
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
      showBufferEnd = true;
      dimInactive = {
        enabled = true;
        percentage = 0.15;
        shade = "dark";
      };
      integrations = {
        cmp = true;
        which_key = true;
        telescope.enabled = true;
      };
      styles = {
        comments = ["italic"];
      };
      transparentBackground = false;
    };
    vimAlias = false;
    options = {
      number = true;
      shiftwidth = 2;
      expandtab = true;
      smartcase = true;
      tabstop = 2;
      smartindent = true;
      cursorline = true;
    };
    plugins.lsp = {
      enable = true;
      servers = {
        ccls.enable = true;
      };
    };
    plugins.nvim-cmp = {
      enable = true;
      autoEnableSources = true;
      sources = [
        {name = "nvim_lsp";}
        {name = "path";}
        {name = "buffer";}
      ];
    };
    plugins.telescope = {
      enable = true;
    };
    plugins = {
      airline.enable = true;
    };
    extraConfigVim = ''
      set colorcolumn=80
      let g:sonokai_style = 'default'
      let g:sonokai_better_performance = 1
      let g:airline_theme='sonokai'
      let g:airline#extensions#tabline#enabled = 1
      let g:airline_powerline_fonts = 1
      let g:sonokai_transparent_background = 1
      let g:sonokai_diagnostic_text_highlight = 1
      let g:sonokai_spell_foreground = 'colored'
      nnoremap <leader>ff <cmd>Telescope find_files<cr>
      nnoremap <leader>fg <cmd>Telescope live_grep<cr>
      nnoremap <leader>fb <cmd>Telescope buffers<cr>
      nnoremap <leader>fh <cmd>Telescope help_tags<cr>
    '';
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "alexander";
    homeDirectory = "/home/alexander";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ galaxy-buds-client ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      Vundle-vim
      clang_complete
      coc-clangd
      vim-airline
      vim-airline-themes
      sonokai
      vim-nix
      LanguageClient-neovim
    ];
    settings = {
      tabstop = 2;
      shiftwidth = 2;
      expandtab = false;
      smartcase = true;
      number = true;
    };
    extraConfig = ''
      let g:sonokai_style = 'default'
      let g:sonokai_better_performance = 1
      let g:airline_theme='sonokai'
      let g:airline#extensions#tabline#enabled = 1
      let g:airline_powerline_fonts = 1
      let g:sonokai_transparent_background = 1
      let g:sonokai_diagnostic_text_highlight = 1
      let g:sonokai_spell_foreground = 'colored'
    '';
  };

  programs.firefox = {
    enable = true;
  };

  programs.starship.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    historySubstringSearch.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
    };
    enableAutosuggestions = true;
  };

  programs.starship.settings = {
    add_newline = false;
    format = "$shlvl$shell$username$hostname$nix_shell$git_branch$git_commit$git_state$git_status$directory$jobs$cmd_duration$character";
    shlvl = {
      disabled = true;
      symbol = "ﰬ";
      style = "bright-red bold";
    };
    shell = {
      disabled = false;
      format = "$indicator";
      fish_indicator = "";
      # bash_indicator = "[BASH](bright-white) ";
      # zsh_indicator = "[ZSH](bright-white) ";
    };
    username = {
      style_user = "bright-white bold";
      style_root = "bright-red bold";
    };
  };

  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
  programs.btop.enable = true;

  programs.bat.enable = true;
  programs.ripgrep.enable = true;

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      auto_sync = true;
      sync_frequency = "5m";
      filter_mode = "host";
      filter_mode_shell_up_key_binding = "session";
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
