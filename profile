#stop hiding Library folder, Apple
chflags nohidden ~/Library
# case insensitive bash filename completion
# shopt -s nocaseglob

# Bypass use of .inputrc with 'bind' syntax
# bind "set completion-ignore-case on"
# bind "set show-all-if-ambiguous on"
# bind "set show-all-if-unmodified on"
# bind "set visible-stats on"

# let's use hub for all my git needs
eval "$(hub alias -s)"

# more colorful subshells
export CLIE_COLOR=1

export GREP_OPTIONS='--color=auto'
export LESS='-iMRXFfx4'
export EDITOR='vim'

# make man colorful
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[1;31m'        # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;33;5;146m' # begin underline

# ensure utf8 is enabled
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# no spying homebrew
export HOMEBREW_NO_ANALYTICS=1

# History: don't store duplicates
export HISTCONTROL=erasedups
# History: 10,000 entries
export HISTSIZE=100000
# e: exit without q at end, r: color codes, X: leave results in buffer
export LESS="-erX"

# export FZF_DEFAULT_COMMAND='ag --hidden -g ""'
export FZF_DEFAULT_COMMAND='rg --files'

# NOTE MacOS needs you to 'touch ~/.iex_history' before it works
export ERL_AFLAGS="-kernel shell_history enabled"

# asdf will build erlang docs available in iex (Elixir 1.11+ and OTP 23+)
export KERL_BUILD_DOCS="yes"

# avoid JInterface stuff in erlang
export KERL_CONFIGURE_OPTIONS="--without-javac"

export PATH=/bin:/usr/local/bin:/usr/local/sbin:~/bin:$PATH

# rg has no default path; must be specified
export RIPGREP_CONFIG_PATH=~/.config/ripgrep

alias vim=nvim
alias ls='ls -aFGh'
alias ll='ls -lah'
alias myip='curl ifconfig.co'
alias :q=exit
alias iep='iex -S mix phx.server'
alias iem='iex -S mix'

function gmux {
  # This is Greg's tmux/wemux so I can stop looking up precise syntax
  # This is a find or create function for how I use tmux
  name=${1:-work} #use 1st arg or "work" as default
  wemux new -s $name || wemux attach-session -t $name
}

# zsh prezto "helpfully" creates this alias
# unalias g
function g {
  if [[ $# > 0 ]]; then
    git "$@"
  else
    git status --short --branch
  fi
}
# get tab completion with my function
__git_complete g _git

# light: source highlight code in clipboard or file to clipboard for pasting
# note: requires `brew install highlight`
# call as either `light <filetype || elixir>` or `light <filetype> <filename>`
# available themes/langs: highlight --list-scripts=themes
function light() {
  if [ -z "$2" ]
    then src="pbpaste"
  else
    src="cat $2"
  fi
  $src | \
    highlight \
      --out-format rtf \
      --syntax ${1:-elixir} \
      --font "Fira Code Retina" \
      --font-size 24 \
      --style github | \
    pbcopy
}

function guitar_tuner {
  #note: requires 'brew install sox'
  n=('' E4 B3 G3 D3 A2 E2);while read -n1 -p 'string? ' i;do case $i in [1-6]) play -n synth pl ${n[i]} fade 0 1 ;; *) echo;break;;esac;done
}


function explain () {
if [ "$#" -eq 0 ]; then
while read  -p "Command: " cmd; do
      curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$cmd"
    done
  echo "Bye!"
elif [ "$#" -eq 1 ]; then
    curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$1"
  else
  echo "Usage"
echo "explain                  interactive mode."
echo "explain 'cmd -o | ...'   one quoted command to explain it."
fi
}

# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="$PATH:/usr/local/opt/fzf/bin"
fi
export FZF_TMUX_HEIGHT='20%'
# TODO there's more fzf setup for zsh

