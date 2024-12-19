{ pkgs, lib, ... }: {
  programs.nixvim = {
    enable = true;

    keymaps = [ ] ++ import ./nixvim/keymaps.nix;

    globals = {
      mapleader = " ";
      have_nerd_font = true;
    };
    performance.byteCompileLua = {
      enable = true;
      nvimRuntime = true;
      plugins = true;
    };

    colorschemes.catppuccin.enable = true;

    plugins = {
      lz-n.enable = true;
      web-devicons.enable = true;
      transparent.enable = true;
      neocord.enable = true;
      intellitab.enable = true;

      telescope = {
        enable = true;
        keymaps = { "<leader>fg" = "live_grep"; };
      };

      which-key = { enable = true; };

      snacks = {
        enable = true;
        settings = {
          bigfile = { enabled = true; };
          notifier = {
            enabled = true;
            timeout = 3000;
          };
          quickfile = { enabled = false; };
          statuscolumn = { enabled = false; };
          words = {
            debounce = 100;
            enabled = true;
          };
        };
      };

      mini = {
        enable = true;
        modules = {
          ai = {
            n_lines = 50;
            search_method = "cover_or_next";
          };
          comment = {
            mappings = {
              comment = "<leader>/";
              comment_line = "<leader>/";
              comment_visual = "<leader>/";
              textobject = "<leader>/";
            };
          };
          diff = { view = { style = "sign"; }; };
          starter = {
            content_hooks = {
              "__unkeyed-1.adding_bullet" = {
                __raw = "require('mini.starter').gen_hook.adding_bullet()";
              };
              "__unkeyed-2.indexing" = {
                __raw =
                  "require('mini.starter').gen_hook.indexing('all', { 'Builtin actions' })";
              };
              "__unkeyed-3.padding" = {
                __raw =
                  "require('mini.starter').gen_hook.aligning('center', 'center')";
              };
            };
            evaluate_single = true;
            header = ''
              ██╗  ██╗██╗    ██╗  ██╗███████╗██████╗ ███████╗███╗   ███╗██╗
              ██║  ██║██║    ██║ ██╔╝██╔════╝██╔══██╗██╔════╝████╗ ████║██║
              ███████║██║    █████╔╝ █████╗  ██████╔╝█████╗  ██╔████╔██║██║
              ██╔══██║██║    ██╔═██╗ ██╔══╝  ██╔══██╗██╔══╝  ██║╚██╔╝██║╚═╝
              ██║  ██║██║    ██║  ██╗███████╗██║  ██║███████╗██║ ╚═╝ ██║██╗
              ╚═╝  ╚═╝╚═╝    ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚═╝
            '';
            items = {
              "__unkeyed-1.buildtin_actions" = {
                __raw = "require('mini.starter').sections.builtin_actions()";
              };
              "__unkeyed-2.recent_files_current_directory" = {
                __raw =
                  "require('mini.starter').sections.recent_files(10, false)";
              };
              "__unkeyed-3.recent_files" = {
                __raw =
                  "require('mini.starter').sections.recent_files(10, true)";
              };
              "__unkeyed-4.sessions" = {
                __raw = "require('mini.starter').sections.sessions(5, true)";
              };
            };
          };
          surround = {
            mappings = {
              add = "gsa";
              delete = "gsd";
              find = "gsf";
              find_left = "gsF";
              highlight = "gsh";
              replace = "gsr";
              update_n_lines = "gsn";
            };
          };
        };
      };
      leap.enable = true;
      blink-cmp = {
        enable = true;
        settings = {
          accept = { auto_brackets = { enabled = false; }; };
          windows.documentation = { auto_show = true; };
          highlight = { use_nvim_cmp_as_default = true; };
          keymap = { preset = "super-tab"; };
          trigger = { signature_help = { enabled = true; }; };
        };
      };
      neo-tree.enable = true;

      cmp = {
        autoEnableSources = true;
        settings.snippet = {
          expand = ''
            function(args)
            require("luasnip").lsp_expand(args.body)
            end
          '';
        };
        settings.sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
          {
            name = "luasnip";
            option = { show_autosnippets = true; };
          }
        ];
      };

      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            lsp_format = "fallback";
            timeout_ms = 2000;
          };
          formatters_by_ft = {
            ruby = [
              "rubocop"
            ];
            bash = [
              "shellcheck"
              "shellharden"
              "shfmt"
            ];
            cpp = [ "clang_format" ];
            javascript = {
              __unkeyed-1 = "prettierd";
              __unkeyed-2 = "prettier";
              timeout_ms = 2000;
              stop_after_first = true;
            };
            "_" = [
              "squeeze_blanks"
              "trim_whitespace"
              "trim_newlines"
            ];
          };

          log_level = "warn";
          notify_on_error = false;
          notify_no_formatters = false;
          formatters = {
            prettierd = {
              command = lib.getExe pkgs.prettierd;
            };
            rubocop = {
              command = lib.getExe pkgs.rubocop;
            };
            shellcheck = {
              command = lib.getExe pkgs.shellcheck;
            };
            shfmt = {
              command = lib.getExe pkgs.shfmt;
            };
            shellharden = {
              command = lib.getExe pkgs.shellharden;
            };
            squeeze_blanks = {
              command = lib.getExe' pkgs.coreutils "cat";
            };
          };
        };
      };

      # lsp-format = { enable = true; };
      #
      # none-ls = {
      #   enable = true;
      #   sources.formatting = {
      #     rubocop.enable = true;
      #     nixfmt.enable = true;
      #   };
      # };

      luasnip = {
        enable = true;
        settings.enable_autosnippets = true;
      };

      nvim-autopairs.enable = true;

      lualine.enable = true;

      treesitter = {
        enable = true;

        settings = {
          auto_install = true;
          ensure_installed = [
            "git_config"
            "git_rebase"
            "gitattributes"
            "gitcommit"
            "gitignore"
          ];
        };
      };
      lsp = {
        enable = true;
        inlayHints = true;
        keymaps = {
          diagnostic = {
            "<leader>j" = "goto_next";
            "<leader>k" = "goto_prev";
          };
        };
        servers = {
          vtsls = {
            enable = true;
            package = pkgs.vtsls;
          };
          nixd = {
            enable = true;
            settings.formatting.command = [ "nixpkgs-fmt" ];
            cmd = [ "nixd" ];
          };
          ruby_lsp = {
            enable = true;
            cmd = [ "bundle" "exec" "ruby-lsp" ];
          };
          rubocop = {
            enable = true;
          };
        };
      };

    };
    autoCmd = [
      {
        event = "TextYankPost";
        group = "highlight_yank";
        callback.__raw = "function() vim.highlight.on_yank { higroup = 'IncSearch', timeout = 200 } end";
      }
    ];
    autoGroups.highlight_yank.clear = true;
  } // import ./nixvim/opts.nix;
}
