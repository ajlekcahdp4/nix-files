{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.modules.firefox;
in {
  options = {
    modules.firefox.enable = lib.mkEnableOption "enable firefox";
  };

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      # Switched to ESR due to https://bbs.archlinux.org/viewtopic.php?id=303079
      # Remove when firefox gets fixed
      package = pkgs.firefox-esr;
      profiles.alexander = {
        search.engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };
          "Home Manager NixOs" = {
            urls = [
              {
                template = "https://mipmip.github.io/home-manager-option-search/";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@hm"];
          };
        };
        search.force = true;

        settings = {
          "browser.startup.page" = 3; # Restore previous tabs
          "browser.toolbars.bookmarks.showInPrivateBrowsing" = true; # Show bookmarks in private tabs as well.
          "browser.toolbars.bookmarks.visibility" = "always"; # Always show the toolbar.
          "services.sync.prefs.sync.layout.spellcheckDefault" = false; # Do not spell-check
          "browser.newtabpage.enabled" = false;
          "browser.newtabpage.introShown" = false;
          "browser.newtabpage.pinned" = [];
          "browser.newtabpage.enhanced" = false;
          "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
          "browser.uiCustomization.state" = ''
            {
              "placements": {
                "TabsToolbar": [
                  "firefox-view-button",
                  "tabbrowser-tabs",
                  "new-tab-button",
                  "alltabs-button"
                ],
                "PersonalToolbar": [
                  "import-button",
                  "personal-bookmarks"
                ]
              }
            }
          '';
        };

        extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
          ublock-origin
          tridactyl
          youtube-shorts-block
        ];

        bookmarks = {
          force = true;
          settings = [
            {
              name = "wikipedia";
              tags = ["wiki"];
              keyword = "wiki";
              url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
            }
            {
              name = "github";
              tags = ["github"];
              keyword = "github";
              url = "https://github.com/";
            }
            {
              name = "mail";
              url = "https://e.mail.ru/inbox/";
            }
            {
              name = "gmail";
              url = "https://mail.google.com/mail/u/0/#inbox";
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
            {
              name = "telegram";
              url = "https://web.telegram.org/a/";
            }
          ];
        };
      };
    };
  };
}
