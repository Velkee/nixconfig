{pkgs, ...}: {
  boot.kernelParams = [
    "fbdev=1"
    "nvidia_drm.fbdev=1"
  ];
  boot.kernelModules = [
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];
  boot.initrd.kernelModules = [
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;

      extraPackages = with pkgs; [nvidia-vaapi-driver];
    };

    nvidia.open = false;
    nvidia.modesetting.enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];
}
