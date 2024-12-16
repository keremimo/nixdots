{ config
, pkgs
, ...
}: {
  programs.nixvim = {
    enable = true;
    luaLoader.enable = true;
    plugins = {
      lz-n.enable = true;

      nvim-autopairs.enable = true;

      plugins.treesitter = {
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
    };
  };
}
