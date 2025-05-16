{
  config,
  lib,
  pkgs,
  username,
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
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
          ovmf.packages = [pkgs.OVMFFull.fd];
          vhostUserPackages = [ pkgs.virtiofsd ];
        };
      };
      spiceUSBRedirection.enable = true;
    };
  };
}
