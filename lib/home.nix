{
  inputs,
  outputs,
  ...
}: let
  inherit (inputs.nixpkgs) lib;
  toElemStr = list: lib.lists.foldr (a: b: a + b) "" list;
  toElemAttrs = list: lib.lists.foldr (a: b: lib.attrsets.mergeAttrsList [a b]) {} list;
  toNameValuePair = attrset: {
    name = toElemStr (builtins.attrNames attrset);
    value = toElemAttrs (builtins.attrValues attrset);
  };
  listAttrsToListNameValuePairs = list: (lib.lists.forEach list toNameValuePair);
in rec {
  mkHomeDir = user: "/home/${user}";

  mkHomeConfig = {
    modules ? [],
    user,
    host,
    additionalSpecialArgs ? {},
  }:
    inputs.home-manager.lib.homeManagerConfiguration (
      let
        inherit (inputs) nixpkgs;
        userSettingModule = _: {
          home = {
            username = user.name;
            homeDirectory = user.homePath;
          };
        };
      in {
        modules =
          builtins.attrValues outputs.homeManagerModules
          ++ modules
          ++ host.homeModules
          ++ [userSettingModule];

        pkgs = nixpkgs.legacyPackages.${host.system};
        extraSpecialArgs =
          {
            inherit inputs outputs;
            extraConfig = {
              inherit host;
              users = {
                "${user.name}" = user;
              };
            };
          }
          // additionalSpecialArgs;
      }
    );

  mkUser = {
    name,
    homePath ? mkHomeDir name,
    groups ? [],
    group ? null,
    uid ? null,
    optionalGroups ? [],
    normalUser ? true,
    homeModules ? [],
  }: {
    inherit name group groups optionalGroups homePath normalUser uid;

    homeModules = homeModules ++ builtins.attrValues outputs.homeManagerModules;
  };

  genUsers = users: f: (inputs.nixpkgs.lib.genAttrs (builtins.attrNames users) (name: f (builtins.getAttr name users)));

  toAttrs = list: builtins.listToAttrs (listAttrsToListNameValuePairs list);

  mkForUsers = users: {
    name,
    option,
  }:
    toAttrs (lib.lists.forEach users (user: lib.attrsets.setAttrByPath ["${user}" "${name}"] option));

  a = mkForUsers ["alexander" "alexey"] {
    name = "myopt";
    option = "val";
  };
  v = builtins.toJSON a;
}
