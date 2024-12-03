{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = "/home/velkee/.ssh/id_ed25519_github";
      };
    };
  };
}