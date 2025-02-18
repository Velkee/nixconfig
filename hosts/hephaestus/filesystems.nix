{
  fileSystems."/" = {
    options = ["noatime" "autodefrag" "compress-force=zstd" "commit=120"];
  };

  fileSystems."/root" = {
    options = ["noatime" "autodefrag" "compress-force=zstd" "commit=120"];
  };

  fileSystems."/home" = {
    options = ["noatime" "autodefrag" "compress-force=zstd" "commit=120"];
  };

  fileSystems."/nix" = {
    options = ["noatime" "autodefrag" "compress-force=zstd" "commit=120"];
  };

  fileSystems."/.snapshots" = {
    options = ["noatime" "autodefrag" "compress-force=zstd" "commit=120"];
  };

  fileSystems."/opt" = {
    options = ["noatime" "autodefrag" "compress-force=zstd" "commit=120"];
  };

  fileSystems."/srv" = {
    options = ["noatime" "autodefrag" "compress-force=zstd" "commit=120"];
  };

  fileSystems."/swap" = {
    options = ["noatime" "autodefrag" "commit=120"];
  };

  fileSystems."/tmp" = {
    options = ["noatime" "autodefrag" "compress-force=zstd" "commit=120"];
  };

  fileSystems."/var" = {
    options = ["noatime" "autodefrag" "compress-force=zstd" "commit=120"];
  };

  fileSystems."/usr/local" = {
    options = ["noatime" "autodefrag" "compress-force=zstd" "commit=120"];
  };

  fileSystems."/var/tmp" = {
    options = ["noatime" "autodefrag" "compress-force=zstd" "commit=120"];
  };

  fileSystems."/var/lib/machines" = {
    options = ["noatime" "autodefrag" "compress-force=zstd" "commit=120"];
  };

  fileSystems."/var/lib/libvirt/images" = {
    options = ["noatime" "autodefrag" "compress-force=zstd" "nodatacow" "commit=120"];
  };

  swapDevices = [{device = "/swap/swapfile";}];
}
