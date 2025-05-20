{
  config,
  lib,
  pkgs,
  username,
  ...
}:
with lib; let
  cfg = config.vr;
in {
  options.vr = {
    enable = mkEnableOption "VR support";
  };
  config = {
    programs.alvr = {
      enable = true;
      openFirewall = true;
    };

    programs.adb.enable = true;
    users.users.${username}.extraGroups = ["adbusers"];
  };
}
