
# Heavily cribbed from
# https://github.com/holman/dotfiles/blob/master/zsh/prompt.zsh
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh
# http://ianloic.com/2011/06/25/git-zsh-prompt/

autoload colors && colors
setopt prompt_subst

git_branch() {
  echo $(/usr/bin/git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  st=$(/usr/bin/git status --porcelain --untracked-files=no 2>/dev/null)
  retVal=$?
  if [[ -z $st && $retVal = 128 ]]
  then
    echo " "
  elif [[ -z $st ]]
  then
    echo " on $(git_prompt_info)"
  else
    echo " on %{$fg_bold[red]%}$(git_prompt_info) ∆%{$reset_color%}"
  fi
}

git_prompt_info () {
  ref=$(/usr/bin/git symbolic-ref HEAD 2>/dev/null) || return
  echo "${ref#refs/heads/}"
}

unpushed () {
  git log @{upstream}.. 2>/dev/null || return
  #/usr/bin/git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ -z $(unpushed) ]]
  then
    echo " "
  else
    echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
  fi
}

# configure rtab
autoload -Uz rtab
zstyle ':prompt:rtab' fish yes
zstyle ':prompt:rtab' nameddirs yes

directory_name(){
  echo "%{$fg_bold[cyan]%}$(rtab $PWD)%{$reset_color%}"
}

export PROMPT=$'%(?..%B%F{red}✗ exit %?%f%b\n)\n $(directory_name)$(git_dirty)$(need_push)› '