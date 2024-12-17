{
 pkgs,
 ...
}: {
  programs.nixvim = {
    enable = true;

    keymaps = []++ import ./nixvim/keymaps.nix;

    globals = {
		mapleader = " ";
		have_nerd_font = true;
	};    

      colorschemes.catppuccin.enable = true;

    plugins = {
      lz-n.enable = true;
      blink-cmp = {
        enable = true;
        settings = {
  accept = {
    auto_brackets = {
      enabled = false;
    };
  };
  windows.documentation = {
    auto_show = true;
  };
  highlight = {
    use_nvim_cmp_as_default = true;
  };
  keymap = {
    preset = "super-tab";
  };
  trigger = {
    signature_help = {
      enabled = true;
    };
  };
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
    { name = "buffer";}
    { 
      name = "luasnip";
      option = {show_autosnippets = true;};
      }
  ];
};

      luasnip = {
        enable = true;
        settings.enable_autosnippets = true;
      };

      nvim-autopairs.enable = true;

      lualine.enable = true;

      treesitter = {
        enable = true;

        settings = {
          # NOTE: You can set whether `nvim-treesitter` should automatically install the grammars.
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
        nil_ls.enable = true;
        ruby_lsp = {
          enable = true;
          cmd = [
          "bundle"
          "exec"
          "ruby-lsp"
          ];
        };
  };
};

    };
  }// import ./nixvim/opts.nix;
}
