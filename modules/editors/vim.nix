# When I'm stuck in the terminal or don't have access to Emacs, (neo)vim is my
# go-to. I am a vimmer at heart, after all.

{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.editors.vim;
    configDir = config.dotfiles.configDir;
    username = config.user.name;
in {
  options.modules.editors.vim = {
    enable = mkBoolOpt false;
    vimrc = {
      enable = mkBoolOpt true;
    };
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      editorconfig-core-c
      unstable.neovim
    ];

    # This is for non-neovim, so it loads my nvim config
    # env.VIMINIT = "let \\$MYVIMRC='\\$XDG_CONFIG_HOME/nvim/init.vim' | source \\$MYVIMRC";

    environment.shellAliases = {
      vim = "nvim";
      v   = "nvim";
    };

    environment.extraInit = mkIf cfg.vimrc.enable ''
      if [ ! -d "$HOME/.config/nvim/vim_runtime" ]; then
        git clone --depth=1 https://github.com/amix/vimrc.git $HOME/.config/nvim/vim_runtime
      fi
    '';

    home.configFile = mkIf cfg.vimrc.enable {
      "nvim/init.vim".text = ''
        set runtimepath+=$HOME/.config/nvim/vim_runtime

        source $HOME/.config/nvim/vim_runtime/vimrcs/basic.vim
        source $HOME/.config/nvim/vim_runtime/vimrcs/filetypes.vim
        source $HOME/.config/nvim/vim_runtime/vimrcs/plugins_config.vim
        source $HOME/.config/nvim/vim_runtime/vimrcs/extended.vim

        try
          source $HOME/.config/nvim/my_configs.vim
        catch
        endtry
      '';
    };
  };
}
