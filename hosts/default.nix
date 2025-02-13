{
  pkgs,
  lib,
  username,
  ...
}: {
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "pipewire"
    ];
  };

  environment.systemPackages = with pkgs; [
    neovim
  ];

  time.timeZone = "Europe/Oslo";

  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nb_NO.UTF-8";
    LC_IDENTIFICATION = "nb_NO.UTF-8";
    LC_MEASUREMENT = "nb_NO.UTF-8";
    LC_MONETARY = "nb_NO.UTF-8";
    LC_NAME = "nb_NO.UTF-8";
    LC_NUMERIC = "nb_NO.UTF-8";
    LC_PAPER = "nb_NO.UTF-8";
    LC_TELEPHONE = "nb_NO.UTF-8";
    LC_TIME = "nb_NO.UTF-8";
  };

  console = {
    keyMap = "no";
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts
      ipafont
      noto-fonts-color-emoji

      nerd-fonts.fira-code
    ];

    enableDefaultPackages = false;

    fontconfig.defaultFonts = {
      serif = [
        "Noto Serif"
        "IPAMincho"
      ];
      sansSerif = [
        "Noto Sans"
        "IPAGothic"
      ];
      monospace = ["FiraCode Nerd Font Mono"];
      emoji = ["Noto Color Emoji"];
    };
  };

  security.rtkit.enable = true;
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
      };

      openFirewall = true;
    };

    udisks2.enable = true;
  };

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
