{ inputs, lib, pkgs, ... }:

with lib;
with lib.my;
let sys = "x86_64-linux";
  darwinSys = "x86_64-darwin";
in {
  mkHost = path: attrs @ { system ? sys, ... }:
    nixosSystem {
      inherit system;
      specialArgs = { inherit lib inputs system; };
      modules = [
        {
          nixpkgs.pkgs = pkgs;
          networking.hostName = mkDefault (removeSuffix ".nix" (baseNameOf path));
        }
        (filterAttrs (n: v: !elem n [ "system" ]) attrs)
        ../.   # /default.nix
        (import path)
      ];
    };

  mapHosts = dir: attrs @ { system ? system, ... }:
    mapModules dir
      (hostPath: mkHost hostPath attrs);

  mkDarwinHost = path: attrs @ { system ? darwinSys, ... }:
    inputs.darwin.lib.darwinSystem {
      inherit system;
      specialArgs = { inherit lib inputs system; };
      modules = [
        {
          _module.args.pkgs = pkgs;
          networking.hostName = mkDefault (removeSuffix ".nix" (baseNameOf path));
        }
        (filterAttrs (n: v: !elem n [ "system" ]) attrs)
        ../.   # /default.nix
        (import path)
      ];
    };
  mapDarwinHosts = dir: attrs @ { system ? system, ... }:
    mapModules dir
      (hostPath: mkDarwinHost hostPath attrs);
}
