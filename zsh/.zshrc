autoload -U compinit && compinit
zstyle ":completion:*" matcher-list "m:{a-z}={A-Z}"
zstyle ":completion:*" select-prompt %SScrolling active: current selection at %p%s

source ~/tmuxinator.zsh

PROMPT_PERCENT=yes;  
PS1="%n@%m:(%d)> %(!.#.$) ";

# {{{ exports
export TERM=xterm-256color
export EDITOR=vim
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE="$HOME/.history"
# }}}
# {{{ setopts
setopt PROMPT_SUBST
setopt ZLE
setopt APPEND_HISTORY
setopt NO_HUP
setopt IGNORE_EOF
setopt NO_CASE_GLOB
setopt NUMERIC_GLOB_SORT
setopt EXTENDED_GLOB
setopt HIST_IGNORE_ALL_DUPS
setopt MULTIOS
setopt CORRECT
setopt GLOB_COMPLETE
setopt PUSHD_MINUS
setopt RM_STAR_WAIT
setopt NO_FLOW_CONTROL
setopt HIST_REDUCE_BLANKS
# }}}
# {{{ unsetopts
unsetopt nomatch
# }}}
# {{{ functions
function mkdcd {
    mkdir -p -v $1
    cd $1
}
# }}}
# {{{ aliases
alias reload="source ~/.zshrc"
alias ping="ping -c 4"
alias pingg="ping google.se"
alias pingg6="ping6 ipv6.google.se"
alias ns="netstat -alnp --protocol=inet"
alias now="date '+%A, %d %B, %G%t%H:%M:%S %Z(%z)'"
alias q=exit
alias cls=clear
alias sniff="sudo ngrep -d 'eth0' -t '^(GET|POST) ' 'tcp and port 80'"
alias urlencode="python -c 'import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);'"
alias updatepip3="pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U"
alias vimpi="vim +PluginInstall +qall"
# }}}

#  vim: foldmethod=marker :
