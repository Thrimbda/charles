{ config, pkgs, callPackage, lib, ... }:

with lib;
with lib.my;
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    vim
    unstable.neovim
    git
    tmux
    htop
    kubectl
    go
    postgresql

    # py39 related
    python39
    python39Packages.pip
    python39Packages.ipython
    python39Packages.black
    python39Packages.setuptools
    python39Packages.pylint
    python39Packages.poetry

    # cachix
    cachix

    # ## Emacs itself
    # binutils       # native-comp needs 'as', provided by this
    # # emacsPgtkGcc   # 28 + pgtk + native-comp
    # ((emacsPackagesNgGen emacsPgtkGcc).emacsWithPackages (epkgs: [
    #   epkgs.vterm
    # ]))

    # ## Doom dependencies
    # git
    # (ripgrep.override {withPCRE2 = true;})
    # gnutls              # for TLS connectivity

    # ## Optional dependencies
    # fd                  # faster projectile indexing
    # imagemagick         # for image-dired
    # (mkIf (config.programs.gnupg.agent.enable)
    #   pinentry_emacs)   # in-emacs gnupg prompts
    # zstd                # for undo-fu-session/undo-tree compression

    # ## Module dependencies
    # # :checkers spell
    # (aspellWithDicts (ds: with ds; [
    #   en en-computers en-science
    # ]))
    # # :tools editorconfig
    # editorconfig-core-c # per-project style config
    # # :tools lookup & :lang org +roam
    # sqlite
    # # :lang javascript
    # nodePackages.typescript-language-server
    # # :lang latex & :lang org (latex previews)
    # texlive.combined.scheme-medium
    # # :lang beancount
    # beancount
    # unstable.fava  # HACK Momentarily broken on nixos-unstable
    # # :lang rust
    # rustfmt
    # unstable.rust-analyzer
  ];

  fonts.fonts = [ pkgs.emacs-all-the-icons-fonts ];

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
  ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
