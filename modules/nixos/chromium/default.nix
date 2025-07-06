{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.chromium;
in {
  options.modules.chromium.enable = lib.mkEnableOption "enable chromium";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [pkgs.chromium];
    programs.chromium = {
      enable = true;
      extensions = [
        # The Great Suspender - https://github.com/deanoemcke/thegreatsuspender
        "klbibkeccnjlkjkiokjodocebajanakg"
        # Vimium - https://github.com/philc/vimium
        "dbepggeogbaibhgnhhndojpepiihcmeb"
        # ublock origin
        "cjpalhdlnbpafiamejdnhcphjbkeiagm"
      ];
      extraOpts = {
        "AllowDinosaurEasterEgg" = false; # : (
        "AllowOutdatedPlugins" = true;
        "CloudReportingEnabled" = false;
        "SafeBrowsingEnabled" = false;
        "ReportSafeBrowsingData" = false;
        "ManagedBookmarks" = [
          {"toplevel_name" = "Managed Bookmarks";}
          {
            "name" = "Daily";
            "children" = [
              {
                "url" = "https://github.com/";
                name = "github";
              }
              {
                "url" = "https://calendar.google.com/calendar/r";
                name = "calendar";
              }
              {
                "url" = "https://gmail.com/";
                name = "gmail";
              }
              {
                name = "mail";
                url = "https://e.mail.ru/inbox/";
              }

              {
                name = "ymail";
                url = "https://mail.yandex.ru";
              }
              {
                name = "youtube";
                url = "https://youtube.com";
              }
              {
                name = "dictionary";
                url = "https://dictionary.cambridge.org";
              }
              {
                name = "translator";
                url = "https://translate.yandex.ru/";
              }
              {
                name = "telegram";
                url = "https://web.telegram.org/a/";
              }
              {
                name = "VK";
                url = "https://vk.com/im";
              }
            ];
          }
        ];
      };
    };
  };
}
