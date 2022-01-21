# modules/dev/go.nix
#
# I don't like golang, but I endure it.
#

{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.dev.go;
in {
  options.modules.dev.go = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      go
    ];

    env.PATH = [ "${config.user.home}/go/bin" ];
  };
}
