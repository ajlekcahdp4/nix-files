{
  pkgs,
  outputs,
  config,
  lib,
  inputs,
  ...
}: {
  options.modules = {
    vscode.enable = lib.mkEnableOption "Enable VSCode";
  };

  config = let
    cfg = config.modules.vscode;
  in
    lib.mkIf cfg.enable {
      programs.vscode = {
        enable = true;
        package = pkgs.vscodium;

        profiles.default = {
          enableUpdateCheck = false;
          enableExtensionUpdateCheck = false;
          extensions =
            (with pkgs.vscode-extensions; [
              llvm-vs-code-extensions.vscode-clangd
              xaver.clang-format
              editorconfig.editorconfig
              ms-python.python
              ms-pyright.pyright
              ms-python.black-formatter
              mkhl.direnv
              ms-vscode.cmake-tools
              waderyan.gitblame
              ms-azuretools.vscode-docker
              gitlab.gitlab-workflow
              github.vscode-pull-request-github
              redhat.vscode-yaml
              catppuccin.catppuccin-vsc
              tomoki1207.pdf
              vscodevim.vim
            ])
            ++ (with pkgs.vscode-extensions; [
              ms-toolsai.jupyter
            ]);
        };
      };
    };
}
