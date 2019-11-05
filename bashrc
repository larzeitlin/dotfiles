alias ls='ls --color=auto'
export PS1="\[\e[36m\]\W \[\e[m\]: "
alias bigs='~/.screenlayout/bigscreen1.sh'
alias laps='~/.screenlayout/lapscreen.sh'
export VISUAL=vim
export EDITOR=vim
export SB_ROOT=~/sb_root/
export JAVA_HOME=/usr/bin/java
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
alias t='xfce4-terminal'

fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR} "${files[@]}"
}

Rg() {
  local file

  file="$(rg "$@" | fzf -0 -1 | awk -F: '{print $1}')"

  if [[ -n $file ]]
  then
     vim $file
  fi
}

bind -x '"\C-p": fe'
