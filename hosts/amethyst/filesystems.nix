{
  fileSystems = {
    "/".options = [
      "compress-force=zstd"
      "noatime"
      "commit=120"
      "autodefrag"
    ];
    "/home".options = [
      "compress-force=zstd"
      "noatime"
      "commit=120"
      "autodefrag"
    ];
    "/nix".options = [
      "compress-force=zstd"
      "noatime"
      "commit=120"
      "autodefrag"
    ];
    "/.swap".options = [
      "noatime"
      "commit=120"
      "autodefrag"
    ];
    "/media/games".options = [
      "compress-force=zstd"
      "noatime"
      "commit=120"
      "autodefrag"
    ];
  };

  swapDevices = [{device = "/.swap/swapfile";}];

  services.btrfs.autoScrub.enable = true;
}
