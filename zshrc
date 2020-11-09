export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="/home/luke/.oh-my-zsh"
ZSH_THEME=robbyrussell
HYPHEN_INSENSITIVE="true"

plugins=(
  git
  zsh-syntax-highlighting
)
SAVEHIST=999999999999
source $ZSH/oh-my-zsh.sh
export VISUAL=vim
export EDITOR=vim
export SB_ROOT=~/sb_root/
export JAVA_HOME=/usr/bin/java
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

fe() {
  </dev/tty vim -c Files
}
zle -N fe
bindkey "^p" fe

Rg() {
  </dev/tty vim -c Rg
}
zle -N Rg
bindkey "^g" Rg


source /usr/share/nvm/init-nvm.sh
bindkey -v

# Remove mode switching delay.
KEYTIMEOUT=5

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
alias notion='$HOME/.notion.sh'