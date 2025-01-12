{ pkgs, config, ... }:
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    shortcut = "C-a";
    aggressiveResize = true;
    baseIndex = 1;
    newSession = true;
    escapeTime = 5;
    historyLimit = 20000;
    bufferLimit = 20;
    displayTime = 1500;
    remainOnExit = false;
    repeatTime = 300;
    allowRename = false;
    automaticRename = false;
    paneBaseIndex = 1;
    statusKeys = "nvim";

    setTitles = true;
    setTitlesString = "#I:#W";

#    plugins = with.pkgs; [];

    extraConfig = ''
      set-option -g default-terminal "tmux-256color" 
      set-option -g focus-events on

      # Unbind default key bindings, we're going to override
      unbind "\$" # rename-session
      unbind ,    # rename-window
      unbind %    # split-window -h
      unbind '"'  # split-window
      unbind "}"    # swap-pane -D
      unbind "{"    # swap-pane -U
      unbind "["    # paste-buffer
      unbind "]"    
      unbind "'"  # select-window
      unbind n    # next-window
      unbind p    # previous-window
      unbind l    # last-window
      unbind M-n  # next window with alert
      unbind M-p  # next window with alert
      unbind o    # focus thru panes
      unbind &    # kill-window
      unbind "#"  # list-buffer 
      unbind =    # choose-buffer
      unbind z    # zoom-pane
      unbind M-Up  # resize 5 rows up
      unbind M-Down # resize 5 rows down
      unbind M-Right # resize 5 rows right
      unbind M-Left # resize 5 rows left


      # Edit configuration and reload
      bind C-e new-window -n 'tmux.conf' "sh -c '\${EDITOR:-vim} ~/.tmux.conf && tmux source ~/.tmux.conf && tmux display \"Config reloaded\"'"

      # reload config
      bind C-r source-file ~/.tmux.conf \; display "Reloaded!"

      # new window and retain cwd
      bind c new-window -c "#{pane_current_path}"

      # Rename session and window
      bind r command-prompt -I "#{window_name}" "rename-window '%%'"
      bind R command-prompt -I "#{session_name}" "rename-session '%%'"

      # splitting
      bind | split-window -h
      bind - split-window -v

      # Select pane and windows
      bind -r C-[ previous-window
      bind -r C-] next-window
      bind -r [ select-pane -t :.-
      bind -r ] select-pane -t :.+
      bind -r Tab last-window   # cycle thru MRU tabs
      bind -r C-o swap-pane -D

      # Zoom pane
      bind + resize-pane -Z

      # Link window
      bind L command-prompt -p "Link window from (session:window): " "link-window -s %% -a"

      # Swap panes back and forth with 1st pane
      # When in main-(horizontal|vertical) layouts, the biggest/widest panel is always @1
      #bind \ if '[ #{pane_index} -eq 1 ]' \
      #     'swap-pane -s "!"' \
      #     'select-pane -t:.1 ; swap-pane -d -t 1 -s "!"'

      # Kill pane/window/session shortcuts
      bind x kill-pane
      bind X kill-window
      bind C-x confirm-before -p "kill other windows? (y/n)" "kill-window -a"
      bind Q confirm-before -p "kill-session #S? (y/n)" kill-session

      # Merge session with another one (e.g. move all windows)
      # If you use adhoc 1-window sessions, and you want to preserve session upon exit
      # but don't want to create a lot of small unnamed 1-window sessions around
      # move all windows from current session to main named one (dev, work, etc)
      bind C-u command-prompt -p "Session to merge with: " \
        "run-shell 'yes | head -n #{session_windows} | xargs -I {} -n 1 tmux movew -t %%'"

      # Detach from session
      bind d detach
      bind D if -F '#{session_many_attached}' \
          'confirm-before -p "Detach other clients? (y/n)" "detach -a"' \
          'display "Session has only 1 client attached"'

      # Hide status bar on demand
      bind C-s if -F '#{s/off//:status}' 'set status off' 'set status on'

      # ==================================================
      # === Window monitoring for activity and silence ===
      # ==================================================
      bind m setw monitor-activity \; display-message 'Monitor window activity [#{?monitor-activity,ON,OFF}]'
      bind M if -F '#{monitor-silence}' \
          'setw monitor-silence 0 ; display-message "Monitor window silence [OFF]"' \
          'command-prompt -p "Monitor silence: interval (s)" "setw monitor-silence %%"'

      # Activity bell and whistles
      set -g visual-activity on

      # TODO: Does not work as well, check on newer versions
      # set -g visual-silence on

      # BUG: bell-action other ignored · Issue #1027 · tmux/tmux · GitHub - https://github.com/tmux/tmux/issues/1027
      # set -g visual-bell on
      # setw -g bell-action other

      # ================================================
      # ===     Copy mode, scroll and clipboard      ===
      # ================================================
      set -g @copy_use_osc52_fallback on

      # Prefer vi style key table
      setw -g mode-keys vi

      bind p paste-buffer
      bind C-p choose-buffer

      # trigger copy mode by
      bind -n M-Up copy-mode

      # Scroll up/down by 1 line, half screen, whole screen
      bind -T copy-mode-vi M-Up              send-keys -X scroll-up
      bind -T copy-mode-vi M-Down            send-keys -X scroll-down
      bind -T copy-mode-vi M-PageUp          send-keys -X halfpage-up
      bind -T copy-mode-vi M-PageDown        send-keys -X halfpage-down
      bind -T copy-mode-vi PageDown          send-keys -X page-down
      bind -T copy-mode-vi PageUp            send-keys -X page-up

      # When scrolling with mouse wheel, reduce number of scrolled rows per tick to "2" (default is 5)
      bind -T copy-mode-vi WheelUpPane       select-pane \; send-keys -X -N 2 scroll-up
      bind -T copy-mode-vi WheelDownPane     select-pane \; send-keys -X -N 2 scroll-down

      # wrap default shell in reattach-to-user-namespace if available
      # there is some hack with `exec & reattach`, credits to "https://github.com/gpakosz/.tmux"
      # don't really understand how it works, but at least window are not renamed to "reattach-to-user-namespace"
      if -b "command -v reattach-to-user-namespace > /dev/null 2>&1" \
          "run 'tmux set -g default-command \"exec $(tmux show -gv default-shell) 2>/dev/null & reattach-to-user-namespace -l $(tmux show -gv default-shell)\"'"

      yank="~/.tmux/yank.sh"

      # Copy selected text
      bind -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "$yank"
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "$yank"
      bind -T copy-mode-vi Y send-keys -X copy-line \;\
          run "tmux save-buffer - | $yank"
      bind-key -T copy-mode-vi D send-keys -X copy-end-of-line \;\
          run "tmux save-buffer - | $yank"
      bind -T copy-mode-vi C-j send-keys -X copy-pipe-and-cancel "$yank"
      bind-key -T copy-mode-vi A send-keys -X append-selection-and-cancel \;\
          run "tmux save-buffer - | $yank"

      # Copy selection on drag end event, but do not cancel copy mode and do not clear selection
      # clear select on subsequence mouse click
      bind -T copy-mode-vi MouseDragEnd1Pane \
          send-keys -X copy-pipe "$yank"
      bind -T copy-mode-vi MouseDown1Pane select-pane \;\
        send-keys -X clear-selection
      
    '';
  };
}
