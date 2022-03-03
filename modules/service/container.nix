# modules/service/container.nix
#
# I want to have a try to replace docker.

{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.service.container;
in {
  options.modules.service.container = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      k9s
    ];
  };
}
