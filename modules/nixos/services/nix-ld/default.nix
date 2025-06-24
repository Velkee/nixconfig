
{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.services.nix-ld;
in {
  options.modules.services.nix-ld = {
    enable = mkEnableOption "Enable the nix-ld compatibility layer";
  };

  config = mkIf cfg.enable {
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [

      ];
    };
  };
}
