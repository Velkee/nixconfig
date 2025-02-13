{
  programs.alvr = {
    enable = true;
    openFirewall = true;
  };

  programs.adb.enable = true;
  users.users.velkee.extraGroups = ["adbusers"];
}
