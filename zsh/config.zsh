export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

fpath=($DOTFILES/functions $fpath)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Prevents the shell from lowering the priority of background jobs
setopt NO_BG_NICE
# Prevents the shell from sending the HUP signal to a job when the shell itself receives a HUP signal
setopt NO_HUP
# Disables the beep you hear when you use the TAB key for listing
setopt NO_LIST_BEEP
# Allows each function to have its own set of options
setopt LOCAL_OPTIONS
# Allows each function to have its own set of traps
setopt LOCAL_TRAPS
# Shares the command history between all active shells
setopt SHARE_HISTORY
# Adds timestamps to each command in the history
setopt EXTENDED_HISTORY
# Allows prompt strings to be evaluated multiple times
setopt PROMPT_SUBST
# Enables spelling correction for commands
setopt CORRECT
# Allows completion to occur within a word
setopt COMPLETE_IN_WORD
# Appends commands to the history file as soon as they are executed
setopt APPEND_HISTORY
# Appends commands to the history file as soon as they are executed and shares them across sessions
setopt INC_APPEND_HISTORY
# Ignores duplicate commands for the history list
setopt HIST_IGNORE_ALL_DUPS
# Removes superfluous blanks from each command line being added to the history list
setopt HIST_REDUCE_BLANKS
# Ignores duplicate commands for the history list
setopt HIST_IGNORE_DUPS
# Ignores commands that start with a space for the history list
setopt HIST_IGNORE_SPACE
# Asks for confirmation before executing a command from the history list
setopt HIST_VERIFY
# Deletes older duplicate commands from the history list first when the history is full
setopt HIST_EXPIRE_DUPS_FIRST
# Doesn't ask for confirmation when executing 'rm *'
setopt RM_STAR_SILENT

bindkey '\e[A' history-substring-search-up
bindkey '\e[B' history-substring-search-down

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey "$terminfo[cuu1]" history-substring-search-up
bindkey "$terminfo[cud1]" history-substring-search-down

bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char
