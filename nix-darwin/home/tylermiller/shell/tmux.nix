{pkgs, ...}: {
  programs = {
    tmux = {
      enable = true;
      mouse = true;
      shortcut = "C-a";
      clock24 = false;
      keyMode = "vi";
      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = catppuccin;
          extraConfig = ''
            set -g @catppuccin_flavour 'mocha'

            set -g @catppuccin_window_default_fill "number"
            set -g @catppuccin_window_default_text "#W"
            set -g @catppuccin_window_current_fill "number"
            set -g @catppuccin_window_current_text "#W"

            set -g @catppuccin_status_modules_right "application session date_time"
            set -g @catppuccin_status_modules_left "directory"

            set -g @catppuccin_date_time_text "%I:%M %p"
          '';
        }
      ];

      extraConfig = ''
        set-option -g status-position top

        # Enable passthrough for image.nvim
        set -g allow-passthrough on

        # Fix terminal colors
        set -g default-terminal "tmux-256color"
        set -ag terminal-overrides ",xterm-256color:RGB"

        # Fix for neovim colors
        set-option -g focus-events on

        # Pane navigation (Ctrl+Shift)
        bind -n C-S-h select-pane -L
        bind -n C-S-j select-pane -D
        bind -n C-S-k select-pane -U
        bind -n C-S-l select-pane -R

        # Window navigation (Ctrl+Shift)
        bind -n C-S-p previous-window
        bind -n C-S-n next-window

        # Window management
        bind -n C-S-t new-window -c "#{pane_current_path}"
        bind -n C-S-w kill-window
        bind -n C-S-Left swap-window -t -1
        bind -n C-S-Right swap-window -t +1

        # Easy splits
        bind -n C-\\ split-window -h -c "#{pane_current_path}"
        bind -n C-- split-window -v -c "#{pane_current_path}"

        # Quick zoom toggle
        bind -n C-S-z resize-pane -Z

        # Start windows and panes at 1, not 0
        set -g base-index 1
        set -g pane-base-index 1

        # Renumber windows when one is closed
        set -g renumber-windows on
      '';
    };
  };
}
