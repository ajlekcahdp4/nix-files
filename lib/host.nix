{
  inputs,
  outputs,
  ...
}: let
  inherit (inputs.nixpkgs) lib;
in {
  mkHostInfo = {
    system,
    homeModules ? [],
    nixosModules ? [],
    hostname,
  }: {
    inherit system homeModules hostname;

    nixosModules = nixosModules ++ [outputs.nixosModules inputs.home-manager.nixosModules.home-manager];
  };

  mkHostSystem = {
    modules ? [],
    hostInfo,
    users ? {},
    additionalSpecialArgs ? {},
  }:
    lib.nixosSystem {
      inherit (hostInfo) system;
      modules = modules ++ hostInfo.nixosModules;
      specialArgs =
        {
          inherit inputs outputs;
          extraConfig = {
            inherit hostInfo users;
          };
        }
        // additionalSpecialArgs;
    };
}
