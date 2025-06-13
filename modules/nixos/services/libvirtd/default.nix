{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (config.modules) user;
  cfg = config.modules.services.libvirtd;
in
  with lib; {
    options.modules.services.libvirtd = {
      enable = mkEnableOption "Enable libvirtd and virt-manager";
    };

    config = mkIf cfg.enable {
      users.users.${user.name}.extraGroups = ["libvirtd"];

      programs.virt-manager.enable = true;

      virtualisation.libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          swtpm.enable = true;
          vhostUserPackages = [
            pkgs.virtiofsd
          ];
          ovmf = {
            enable = true;
            packages = with pkgs; [
              OVMFFull.fd
            ];
          };
        };
      };
    };
  }
