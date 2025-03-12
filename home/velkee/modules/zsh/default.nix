{
  programs.starship = {
    enable = true;
  };

  xdg.configFile."starship.toml".source = ./starship.toml;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
    };
    history.size = 10000;
  };
}
