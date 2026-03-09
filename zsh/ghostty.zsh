#!/usr/bin/env zsh

# Ghostty terminal window title customization
set-window-title() {
  # /Users/lachlan/Projects/dotfiles -> ~/p/dotfiles
  window_title="\e]0;${${PWD/#"$HOME"/~}/Projects/P}\a"
  echo -ne "$window_title"
}

if [[ "${TERM_PROGRAM:-}" == "ghostty" ]]; then
  PR_TITLEBAR=''
  set-window-title
  # add-zsh-hook precmd set-window-title

  # Reset terminal mouse tracking modes before each prompt.
  # Prevents garbage escape sequences after an SSH/tmux session dies.
  _reset_mouse_tracking() {
    printf '\e[?1000l\e[?1002l\e[?1003l\e[?1006l'
  }
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd _reset_mouse_tracking
fi
