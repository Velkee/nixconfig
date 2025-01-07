{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimdiffAlias = true;

    opts = {
      number = true;
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

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
      };
    };

    # Split me!
    plugins = {
      nvim-autopairs = {
        enable = true;
        settings = {
          disable_filetype = [
            "TelescopePrompt"
            "vim"
          ];
        };
      };

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
            lua = [
              "stylua"
            ];
            rust = [
              "rustfmt"
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

      lsp = {
        enable = true;
        onAttach = ''
          if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = vim.api.nvim_create_augroup("Format", { clear = true }),
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format()
              end,
            })
          end
        '';
        capabilities = "require('cmp_nvim_lsp').default_capabilities()";

        servers = {
          eslint.enable = true;
          html.enable = true;
          cssls.enable = true;
          jsonls.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
            installRustfmt = true;
          };
          yamlls.enable = true;
          taplo.enable = true;
          nixd.enable = true;
        };
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          snippet = {
            expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          };
          mapping = {
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.close()";
            "<CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true, })";
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
        };
      };

      lualine.enable = true;
      neo-tree.enable = true;

      treesitter = {
        enable = true;
        settings = {
          highlight = {
            enable = true;
            additional_vim_regex_highlighting = false;
          };
          indent.enable = true;
          autotag.enable = true;
          ensure_installed = [
            "nix"
            "json"
            "javascript"
            "typescript"
            "tsx"
            "yaml"
            "toml"
            "html"
            "css"
            "markdown"
            "markdown_inline"
            "bash"
            "lua"
            "vim"
            "dockerfile"
            "gitignore"
            "c"
            "rust"
          ];
          incremental_selection = {
            enable = true;
            keymaps = {
              init_selection = "<C-space>";
              node_incremental = "<C-space>";
              scope_incremental = false;
              node_decremental = "<bs>";
            };
          };
          rainbow = {
            enable = true;
            disable = [
              "html"
            ];
            extended_mode = false;
            max_file_lines = "nil";
          };
          context_commentstring = {
            enable = true;
            enable_autocmd = false;
          };
        };
      };

      web-devicons.enable = true;
    };
  };
}
