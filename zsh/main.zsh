#!/bin/zsh

## Primary zsh file, delegates to .dotfiles/**/.zsh

# shortcut to this dotfiles path
export DOTFILES=$HOME/.dotfiles

# all of our zsh files (excluding this main file to avoid recursion)
typeset -U config_files
config_files=($DOTFILES/*/*.zsh)
config_files=(${config_files:#$DOTFILES/zsh/main.zsh})

# On how to set PATH in macOS:
# https://gist.github.com/Linerre/f11ad4a6a934dcf01ee8415c9457e7b2

# Only set up PATH if we're not in a Hermit environment
if [[ -z "$HERMIT_ENV" ]]; then
  # remove duplicate entries from $PATH
  typeset -U PATH path
  path=("$HOME/bin" "$DOTFILES/bin" "$HOME/.local/bin" $path "/opt/homebrew/sbin" "/opt/homebrew/bin")

  # load the path files
  for file in ${(M)config_files:#*/path.zsh} ; do
    source $file
  done
fi

# Lazy-load antidote and generate the static load file only when needed
zsh_plugins=${ZDOTDIR:-$HOME}/.zsh_plugins
if [[ ! ${HOME}/.zsh_plugins.zsh -nt ${HOME}/.dotfiles/zsh/zsh_plugins.txt ]]; then
  (
    source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
    antidote bundle <${HOME}/.dotfiles/zsh/zsh_plugins.txt >${HOME}/.zsh_plugins.zsh
  )
fi
source ${HOME}/.zsh_plugins.zsh

# zsh-history-substring-search configuration
bindkey '^[[A' history-substring-search-up # or '\eOA'
bindkey '^[[B' history-substring-search-down # or '\eOB'
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

# load everything but the path and completion files (exclude private overrides)
for file in ${${${config_files:#*/path.zsh}:#*/completion.zsh}:#*/*.private.zsh} ; do
  source $file
done

# load private overrides (ignored files: zsh/*.private.zsh)
for file in $DOTFILES/zsh/*.private.zsh(N) ; do
  source $file
done

autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

# load every completion after autocomplete loads
for file in ${(M)config_files:#*/completion.zsh} ; do
  source $file
done

# Load starship
eval "$(starship init zsh)"

# FZF configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"

# fzf-tab configuration
# disable sort when completing options of any command
zstyle ':completion:complete:*:options' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color=always $realpath'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

unset config_files

# Skip forward/back a word with opt-arrow
bindkey '[C' forward-word
bindkey '[D' backward-word

# delegate to defaults
test ! -e ~/.profile || source ~/.profile
test ! -e ~/.zprofile || source ~/.zprofile
