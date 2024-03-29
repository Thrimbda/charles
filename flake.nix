{
  description = "An example NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";             # primary nixpkgs
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";  # for packages on the edge
    home-manager.url = "github:rycee/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Nix darwin
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Extras
    emacs-overlay.url  = "github:nix-community/emacs-overlay";
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, ... }:
    let
      inherit (lib.my) mapModules mapModulesRec mapHosts mapDarwinHosts;
      system = "aarch64-darwin";
      mkPkgs = pkgs: extraOverlays: import pkgs {
        inherit system;
        config.allowUnfree = true;  # forgive me Stallman senpai
        overlays = extraOverlays ++ (lib.attrValues self.overlays);
      };
      pkgs  = mkPkgs nixpkgs [ self.overlay ];
      pkgs' = mkPkgs nixpkgs-unstable [];

      lib = nixpkgs.lib.extend
        (self: super: { my = import ./lib { inherit pkgs inputs; lib = self; }; });
    in {
      lib = lib.my;

      overlay =
        final: prev: {
          unstable = pkgs';
        };

      overlays =
        mapModules ./overlays import;

      nixosModules =
        { dotfiles = import ./.; } // mapModulesRec ./modules import;

      darwinConfigurations =
        mapDarwinHosts ./hosts {};
  };
}
