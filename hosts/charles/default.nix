{ pkgs, config, lib, ... }:
{
  ## Modules
  modules = {
    dev = {
      go.enable = true;
      node.enable = true;
      node.enableGlobally = true;
      # rust.enable = true;
      # rust.enableGlobally = true;
      python.enable = true;
      python.enableGlobally = true;
      postgresql.enable = true;
      # scala.enable = true;
      # java.enable = true;
    };
    editors = {
      default = "nvim";
      emacs.enable = true;
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