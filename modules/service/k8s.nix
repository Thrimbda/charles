{ config, options, pkgs, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.k8s;
in {
  options.modules.services.k8s = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {

    user.packages = with pkgs; [
      # k3s
      k9s
      tilt
    ];
    # This is required so that pod can reach the API server (running on port 6443 by default)
    # networking.firewall.allowedTCPPorts = [ 6443 ];
    # services.k3s.enable = true;
    # services.k3s.role = "server";
    # services.k3s.extraFlags = toString [
    #   # "--kubelet-arg=v=4" # Optionally add additional args to k3s
    # ];
    # environment.systemPackages = with pkgs; [
    #   # Aha! we're running k3s actually.
    #   k3s
    # ];
  };
}