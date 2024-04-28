{lib, ...}: {
  programs.eza = {
    enable = true;
    git = true;
    icons = lib.mkDefault true;

    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };
}
