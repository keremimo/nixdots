{
  config,
  pkgs,
  ...
}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
    set fish_greeting
    '';

    functions = {
	__fish_greeting = "";
    };

    shellAliases = {
	cd = "z";
	ls = "eza";
    };
  };

  programs.zoxide = {
	enable = true;
	enableFishIntegration = true;
  };
  programs.thefuck.enable = true;
}
