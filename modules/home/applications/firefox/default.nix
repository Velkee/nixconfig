{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.modules) user;
  cfg = config.modules.applications.firefox;
in {
  options.modules.applications.firefox = {
    enable = mkEnableOption "Enable firefox browser";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
      programs.firefox = {
        enable = true;
        profiles."default".settings = mkIf config.modules.system.video.nvidia.enable {
          "media.ffmpeg.vaapi.enabled" = true;
          "widget.dmabuf.force-enabled" = true;
        };
      };

      stylix.targets.firefox.profileNames = ["default"];
    };
  };
}
