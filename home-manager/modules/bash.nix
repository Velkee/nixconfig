{
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      export GPG_TTY=$(tty)
    '';
  };
}
