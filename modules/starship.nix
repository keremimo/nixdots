{
  config,
  pkgs,
  ...
}: 

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableTransience = true;
    settings = {
	format = "[ 󰣇 ](bg:#6c7086 fg:#f2cdcd)[](bg:#313244 fg:#6c7086)$directory[](fg:#313244 bg:#394260)$git_branch$git_status[](fg:#394260 bg:#212736)$nodejs$rust$golang$php[](fg:#212736 bg:#1d2230)$time[ ](fg:#1d2230)
$character
";
	character = {
		success_symbol = "[󰋇](#f2cdcd)";
		error_symbol = "[](#f38ba8)";
	};
	directory = {
style = "fg:#cdd6f4 bg:#313244";
format = "[ $path ]($style)";
truncation_length = 3;
truncation_symbol = "…/";
	};
      rust = {
        symbol = "";
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      golang = {
        symbol = "";
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      php = {
        symbol = "";
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      time = {
        disabled = false;
        time_format = "%R"; # Hour:Minute Format
        style = "bg:#1e1e2e";
        format = "[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)";
      };
      git_branch = {
        symbol = "";
        style = "bg:#394260";
        format = "[[ $symbol $branch ](fg:#cdd6f4 bg:#394260)]($style)";
      };
      git_status = {
        style = "bg:#cdd6f4";
        format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
      };
    };
};
}

