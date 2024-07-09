{
  inputs,
  outputs,
  ...
}: let
  callLib = path: import path {inherit inputs outputs;};
  host = callLib ./host.nix;
  home = callLib ./home.nix;
in
  host // home
