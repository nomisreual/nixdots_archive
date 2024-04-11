{
  config,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      {
        plugin = dracula;
        extraConfig = ''
          set -g @dracula-show-left-icon 󰌽
          set -g @dracula-plugins "time"
          set -g @dracula-show-powerline true
        '';
      }
    ];
    extraConfig = ''
      # Compatibility with neovim:
      set-option -g default-terminal "screen-256color"
      set-option -sa terminal-features ",screen-256color:RGB"

      # Rebind prefix:
      unbind C-b
      set-option -g prefix C-s
      bind-key C-s send-prefix

      # ESC time-out
      set -s escape-time 0

      # Enable mouse control (clickable windows, panes, resizable panes)
      set -g mouse on

      # don't rename windows automatically
      set-option -g allow-rename off

      # split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

      # status bar top
      set-option -g status-position top
    '';
  };
}
