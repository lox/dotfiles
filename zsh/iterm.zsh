set-window-title() {
  # /Users/lachlan/Projects/dotfiles -> ~/p/dotfiles
  window_title="\e]0;${${PWD/#"$HOME"/~}/Projects/P}\a"
  echo -ne "$window_title"
}

PR_TITLEBAR=''
set-window-title
# add-zsh-hook precmd set-window-title
