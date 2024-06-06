# modules/dev/node.nix --- https://nodejs.org/en/
#
# Deno shows me an amazing future of JavaScript

{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let
  devCfg = config.modules.dev;
  cfg = devCfg.deno;
in
{
  options.modules.dev.deno = {
    enable = mkBoolOpt false;
  };

  config = mkMerge [
    (
      let deno = pkgs.deno;
      in
      mkIf cfg.enable {
        user.packages = [
          deno
        ];
      }
    )
  ];
}
