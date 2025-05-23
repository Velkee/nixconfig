{
  pkgs,
  lib,
  username,
  ...
}: {
  imports = [
    ./docker.nix
    ./hyprland.nix
    ./libvirt.nix
    ./openrgb.nix
    ./sddm.nix
    ./steam.nix
    ./tailscale.nix
    ./unbound.nix
    ./wine.nix
    ./vr.nix
  ];

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "pipewire"
    ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  environment.pathsToLink = ["/share/zsh"];

  boot.loader = {
    grub = {
      efiSupport = true;
      device = "nodev";
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  environment.systemPackages = with pkgs; [
    neovim
  ];

  time.timeZone = "Europe/Oslo";

  i18n = {
    defaultLocale = lib.mkDefault "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
      "nb_NO.UTF-8/UTF-8"
    ];

    extraLocaleSettings = {
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
  };

  console = {
    keyMap = "no";
  };

  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      ipaexfont
      nerd-fonts.fira-code
      noto-fonts-color-emoji
      source-han-sans-korean
      source-han-sans-simplified-chinese
      source-han-serif-korean
      source-han-serif-simplified-chinese
      source-sans
      source-serif
    ];

    fontconfig = {
      defaultFonts = {
        serif = [
          "Source Serif 4"
          "IPAexMincho"
        ];
        sansSerif = [
          "Source Sans 3"
          "IPAexGothic"
        ];
        monospace = ["FiraCode Nerd Font Mono"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };

  security = {
    rtkit.enable = true;
    sudo-rs.enable = true;
    sudo.enable = false;
  };
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
      publish = {
        enable = true;
        addresses = true;
      };
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
