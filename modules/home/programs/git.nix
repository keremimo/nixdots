{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Kerem Kilic";
        email = "git@keremk.be";
        init.defaultBranch = "main";
      };
    };
  };
}
