{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimdiffAlias = true;

    diagnostic.settings = {
      virtual_lines = true;
    };

    opts = {
      number = true;
      relativenumber = true;
      clipboard = "unnamedplus";
      autoindent = true;
      cursorline = true;
      expandtab = true;
      shiftwidth = 2;
      softtabstop = 2;
      title = true;
      showmatch = true;
      inccommand = "split";
      splitright = true;
      splitbelow = true;
      termguicolors = true;
    };

    # Split me!
    plugins = {
      nvim-autopairs.enable = true;

      colorizer.enable = true;

      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            javascript = [
              "prettier"
            ];
            typescript = [
              "prettier"
            ];
            javascriptreact = [
              "prettier"
            ];
            typescriptreact = [
              "prettier"
            ];
            css = [
              "prettier"
            ];
            html = [
              "prettier"
            ];
            json = [
              "prettier"
            ];
            yaml = [
              "prettier"
            ];
            markdown = [
              "prettier"
            ];
            svelte = [
              "prettier"
            ];
            lua = [
              "stylua"
            ];
            rust = [
              "rustfmt"
            ];
            nix = [
              "alejandra"
            ];
          };
          format_on_save = {
            lsp_fallback = true;
            async = false;
            timeout_ms = 1000;
          };
        };
      };

      gitsigns = {
        enable = true;
        settings = {
          signs = {
            add = {
              text = "|";
            };
            change = {
              text = "|";
            };
            delete = {
              text = "_";
            };
            topdelete = {
              text = "‾";
            };
            changedelete = {
              text = "~";
            };
            untracked = {
              text = "┆";
            };
          };
          signcolumn = true;
          numhl = false;
          linehl = false;
          word_diff = false;
          watch_gitdir = {
            interval = 1000;
            follow_files = true;
          };
          attach_to_untracked = true;
          current_line_blame = false;
          current_line_blame_opts = {
            virt_text = true;
            virt_text_pos = "eol";
            delay = 1000;
            ignore_whitespace = false;
          };
          current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>";
          sign_priority = 6;
          update_debounce = 100;
          status_formatter = "nil";
          max_file_length = 40000;
          preview_config = {
            border = "single";
            style = "minimal";
            relative = "cursor";
            row = 0;
            col = 1;
          };
        };
      };

      lspconfig.enable = true;

      cmp = {
        enable = true;
        settings = {
          snippet = {
            expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          };
          mapping = {
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.close()";
            "<CR>" = "cmp.mapping.confirm({ select = true, })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
          sources = [
            {name = "nvim_lsp";}
            {name = "luasnip";}
            {name = "path";}
            {name = "buffer";}
          ];
        };
      };

      lualine.enable = true;
      neo-tree.enable = true;

      telescope = {
        enable = true;
        keymaps = {
          "<leader>fg" = "live_grep";
        };
      };

      treesitter = {
        enable = true;
        settings = {
          highlight = {
            enable = true;
            additional_vim_regex_highlighting = false;
          };
          indent.enable = true;
          incremental_selection = {
            enable = true;
            keymaps = {
              init_selection = "<C-space>";
              node_incremental = "<C-space>";
              scope_incremental = false;
              node_decremental = "<bs>";
            };
          };
        };
      };

      web-devicons.enable = true;
    };

    dependencies = {
      ripgrep.enable = true;
    };

    lsp = {
      inlayHints.enable = true;
      servers = {
        eslint.enable = true;
        html.enable = true;
        cssls.enable = true;
        jsonls.enable = true;
        rust_analyzer.enable = true;
        yamlls.enable = true;
        nil_ls.enable = true;
        lua_ls.enable = true;
        docker_compose_language_service.enable = true;
      };
    };
  };
}
