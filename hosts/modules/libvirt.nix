{
  username,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.libvirt;
in {
  options.libvirt = {
    enable = mkEnableOption "Virt-manager and libvirt";
  };

  config = mkIf cfg.enable {
    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = ["${username}"];
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
  };
}
