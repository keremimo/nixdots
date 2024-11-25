{config, pkgs, ...}: {
  programs.fish = {
    enable = true;

    extraPaths = [ "/home/kerem/.spicetify" ];

    aliases = {
      cd = "z";
      ls = "eza";
    };

    environmentVariables = {
      EDITOR = "nvim";
      fzf_preview_dir_cmd = "eza --all --color=always";
      fzf_fd_opts = "--hidden --max-depth 5";
    };

    keyBindings = {
      hybrid = ''
        for mode in default insert visual
            fish_default_key_bindings -M $mode
        end
        fish_vi_key_bindings --no-erase
      '';
    };

    extraConfig = ''
      if status is-interactive
          # Commands to run in interactive sessions can go here
      end

      function fish_greeting
        #kitten icat --align left ~/Pictures/okay.png
      end

      zoxide init fish | source
      thefuck --alias | source

      function starship_transient_prompt_func
        starship module character
      end

      function starship_transient_rprompt_func
        starship module time
      end
    '';
  };

  programs.starship = {
    enable = true;
    enableTransience = true;
  };

  programs.zoxide.enable = true;
  programs.thefuck.enable = true;

  environment.systemPackages = with pkgs; [ eza ];
}
