{
  pkgs,
  outputs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.nixvim;
in {
  options = {
    modules.nixvim.enable = lib.mkEnableOption "enable nixvim";
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      enableMan = true;
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
        };
        keymaps.lspBuf = {
          gD = "references";
          gd = "definition";
          gi = "implementation";
          gt = "type_definition";
        };
      };
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
      plugins.airline = {
        enable = true;
        settings = {
          theme = lib.mkForce "catppuccin";
        };
      };
      extraConfigVim = ''
        let g:airline#extensions#tabline#enabled = 1
        let g:airline_powerline_fonts = 1
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
