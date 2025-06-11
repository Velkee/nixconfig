{
  lib,
  config,
  ...
}: let
  cfg = config.modules.system.locale;
in
  with lib; {
    options.modules.system.locale = {
      defaultLocale = mkOption {
        type = types.str;
        default = "en_US.UTF-8";
        description = "Which locale to be used at the system's default";
      };
      formatLocale = mkOption {
        type = types.str;
        default = "nb_NO.UTF-8";
        description = "Which locale to use for formatting of time, dates, etc.";
      };
      extraLocales = mkOption {
        type = with types; either (listOf str) (enum ["all"]);
        default = ["ja_JP.UTF-8/UTF-8"];
        description = "Extra locales to configure";
      };
    };
    config = {
      i18n = {
        defaultLocale = cfg.defaultLocale;
        extraLocaleSettings = {
          LC_ADDRESS = cfg.formatLocale;
          LC_MONETARY = cfg.formatLocale;
          LC_MEASUREMENT = cfg.formatLocale;
          LC_NAME = cfg.formatLocale;
          LC_NUMERIC = cfg.formatLocale;
          LC_PAPER = cfg.formatLocale;
          LC_TELEPHONE = cfg.formatLocale;
          LC_TIME = cfg.formatLocale;
        };
        extraLocales = cfg.extraLocales;
      };
    };
  }
