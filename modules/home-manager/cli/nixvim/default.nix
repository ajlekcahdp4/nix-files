{
  pkgs,
  inputs,
  outputs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.nixvim;
in {
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  options = {
    modules.nixvim.enable = lib.mkEnableOption "enable nixvim";
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      enableMan = true;
      clipboard.providers.xclip.enable = true;
      colorschemes.catppuccin = {
        enable = true;
        settings = {
          flavour = "mocha";
          showBufferEnd = true;
          dimInactive = {
            enabled = true;
            percentage = 0.15;
            shade = "dark";
          };
          styles = {
            comments = ["italic"];
          };
          transparentBackground = true;
        };
      };

      vimAlias = true;

      opts = {
        number = true;
        shiftwidth = 2;
        expandtab = true;
        smartcase = true;
        tabstop = 2;
        smartindent = true;
        cursorline = true;
        colorcolumn = "80";
      };
      plugins.luasnip.enable = true;
      plugins.lsp = {
        enable = true;
        servers = {
          clangd = {
            enable = true;
            autostart = true;
            package = pkgs.clang-tools_18;
          };
          nixd = {
            enable = true;
            autostart = true;
          };
          tinymist.enable = true;
        };
        keymaps.lspBuf = {
          gD = "references";
          gd = "definition";
          gi = "implementation";
          gt = "type_definition";
        };
      };
      autoCmd = [
        {
          event = [
            "BufNewFile"
            "BufRead"
          ];
          pattern = [
            "meson.build"
            "meson_options.txt"
            "meson.options"
          ];
          callback.__raw = ''
            function(args)
               local match = vim.fs.find(
                 {"meson_options.txt", "meson.options", ".git"},
                 {path = args.file, upward = true}
               )[1]
               local root_dir = match and vim.fn.fnamemodify(match, ":p:h") or nil
               vim.lsp.start({
                 name = "mesonlsp",
                 cmd = {"${lib.getExe pkgs.mesonlsp}", "--lsp"},
                 root_dir = root_dir,
               })
             end
          '';
        }
      ];

      plugins.cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          snippet.expand = ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';
          sources = [{name = "nvim_lsp";}];
        };
      };
      plugins.telescope = {
        enable = true;
        keymaps = {
          "<leader>fg" = "live_grep";
          "<leader>ff" = "find_files";
          "<leader>fh" = "help_tags";
          "<leader>fb" = "buffers";
        };
      };
      plugins.yazi.enable = true;
      keymaps = [
        {
          mode = "n";
          key = "<leader>lf";
          action = ''<cmd>lua require("yazi").yazi()<cr>'';
          options = {
            desc = "[P]Opens the yazi file browser";
          };
        }
      ];
      plugins.web-devicons.enable = true;
      plugins.airline = {
        enable = true;
        settings = {
          theme = lib.mkForce "catppuccin";
          powerline_fonts = 1;
        };
      };
      plugins.image = {
        enable = true;
        package = pkgs.vimPlugins.image-nvim;
      };
      plugins.molten = {
        enable = true;
        settings.image_provider = "image.nvim";
      };
      extraPackages = with pkgs; [imagemagick];
      extraPython3Packages = p:
        with p; [
          pynvim
          jupyter-client
          matplotlib
          scikit-learn
          seaborn
          statsmodels
          scipy
          jupyter-core
          cairosvg
          pnglatex
          plotly
          pyperclip
          nbformat
          jupytext
          ipykernel
        ];
      extraConfigVim = ''
        let g:airline#extensions#tabline#enabled = 1
        set mouse=""
      '';
      extraConfigLua = ''
        local cmp = require'cmp'
        cmp.setup({
          mapping = cmp.mapping.preset.insert({
           ['<C-b>'] = cmp.mapping.scroll_docs(-4),
           ['<C-f>'] = cmp.mapping.scroll_docs(4),
           ['<C-Space>'] = cmp.mapping.complete(),
           ['<C-e>'] = cmp.mapping.abort(),
           ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          })
        })
      '';
    };
  };
}
