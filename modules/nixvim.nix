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

      neo-tree.enable = true;

      cmp = {
  autoEnableSources = true;
  settings.sources = [
    { name = "nvim_lsp"; }
    { name = "path"; }
    { name = "buffer"; }
  ];
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
      keymaps = {
      diagnostic = {
        "<leader>j" = "goto_next";
        "<leader>k" = "goto_prev";
      };
      };
      servers = {
	ruby_lsp = {
		enable = true;
		filetypes = [
		"rb"
		"erb"
		];
	};
};
};

    };
  }// import ./nixvim/opts.nix;
}
