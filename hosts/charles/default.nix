{ pkgs, config, lib, ... }:
{
  ## Modules
  modules = {
    dev = {
      go.enable = true;
      node.enable = true;
      python.enable = true;
      java.enable = true;
    };
    editors = {
      default = "nvim";
      emacs = {
        enable = true;
        doom.enable = true;
      };
      vim.enable = true;
    };
    shell = {
      direnv.enable = true;
      git.enable    = true;
      # gnupg.enable  = true;
      tmux.enable   = true;
      zsh.enable    = true;
    };
    services = {
      k8s.enable = true;
    };
  };

  time.timeZone = "Asia/Shanghai";
}