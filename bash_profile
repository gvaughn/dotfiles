#stop hiding Library folder, Apple
chflags nohidden ~/Library
# case insensitive bash filename completion
shopt -s nocaseglob

# Bypass use of .inputrc with 'bind' syntax
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"
bind "set show-all-if-unmodified on"
bind "set visible-stats on"

# git goodies
#PS1='\[\033[G\][\u@\h \W$(__git_ps1 " (%s)")]\$ '
# below 'gv' hardcoded instead of 'enduser'
PS1='\[\033[G\][gv@\h \W$(__git_ps1 " (%s)")]\$ '
#export GIT_AUTHOR_EMAIL=greg.vaughn@livingsocial.com
# let's use hub for all my git needs
eval "$(hub alias -s)"

export GREP_OPTIONS='--color=auto'
export LESS='-iMRXFfx4'
#export VISUAL='mvim'
export EDITOR='vim'
export JAVA_CMD='java'

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

# brew install bash-completion for this to work
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# History: don't store duplicates
export HISTCONTROL=erasedups
# History: 10,000 entries
export HISTSIZE=100000
# e: exit without q at end, r: color codes, X: leave results in buffer
export LESS="-erX"

export FZF_DEFAULT_COMMAND='ag --hidden -g ""'

# control Terminal.app tab names
function tabname {
  printf "\e]1;$1\a"
}
 
function winname {
  printf "\e]2;$1\a"
}

export RUBYOPT=-Itest # so we can just invoke ruby test/unit/foo.rb

export PATH=/usr/local/opt/postgresql@9.5/bin:/usr/local/bin:/usr/local/sbin:~/bin:/usr/local/heroku/bin:/usr/local/mysql/bin:$PATH
# so bundle open {gemname} works
export BUNDLER_EDITOR=v

# manage JVM now that I'm doing some clojure
# function setjdk() {
#   if [ $# -ne 0 ]; then
#     removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
#     if [ -n "${JAVA_HOME+x}" ]; then
#       removeFromPath $JAVA_HOME
#     fi
#     export JAVA_HOME=`/usr/libexec/java_home -v $@`
#     export PATH=$JAVA_HOME/bin:$PATH
#   fi
# }
# function removeFromPath() {
#   export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
# }
# setjdk 1.7

#alias vim='mvim -v'
alias vim=nvim
alias ls='ls -aFGh'
alias ll='ls -lah'
alias flush='echo "flush_all" | nc localhost 11211'
alias flushredis='redis-cli flushall'
alias raket='USE_TURN=true time rake | grep -v PASS; growlnotify -s -m "Rake tests: DONE"'
alias update_submodules='git pull --recurse-submodules && git submodule update'
#alias mdns_restart='sudo killall -HUP mDNSResponder'
# above is pre-Yosemite
alias dns_restart='sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.discoveryd.plist && sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.discoveryd.plist'
alias dns_flush='sudo arp -a -d; sudo dscacheutil -flushcache'
alias gemkill='gem list | cut -d" " -f1 | xargs gem uninstall -aIx'
alias bl='bundle --local'
alias b='(bundle check || bundle --local --jobs=4 || bundle --jobs=4)'
alias ri='ri -f ansi'
alias rc='test -e script/console && bundle exec script/console "$@" || bundle exec rails console "$@"'
#alias iex='rlwrap -H "/Users/gv/.iex_history" -c -D 3 -r iex'
alias port_holder='sudo lsof -i -P | grep -i "listen"'
alias pryr='pry -r ./config/environment.rb'
alias nginx_start='launchctl start homebrew.mxcl.nginx'
alias resqueweb='bundle exec resque-web'
alias :q=exit
# join.me mutes globally; this fixes it
alias micfix="osascript -e 'set volume input volume 80'"
alias add_ssh_ids="ssh-add ~/.ssh/*rsa*"
alias natinfo="natutil -vx -s"
alias webpack-watcher="$(npm bin)/webpack --progress --colors --watch -d"
alias ag='ag --path-to-agignore ~/.agignore'
# autocorrect all changed files
alias autorubo='git diff `git merge-base origin/master HEAD` --name-only | xargs -I {} rubocop --auto-correct {}'
alias npm-exec='PATH=$(npm bin):$PATH'

alias iep='iex -S mix phoenix.server'
alias iem='iex -S mix'

function gmux {
  # This is Greg's tmux/wemux so I can stop looking up precise syntax
  # This is a find or create function for how I use tmux
  name=${1:-work} #use 1st arg or "work" as default
  wemux new -s $name || wemux attach-session -t $name
}

function g {
  if [[ $# > 0 ]]; then
    git "$@"
  else
    git status --short --branch
  fi
}
# get tab completion with my function
__git_complete g _git

 function light() {
  if [ -z "$2" ]
    then src="pbpaste"
  else
    src="cat $2"
  fi
  $src | highlight -O rtf --syntax $1 --font Inconsolata --style solarized-dark --font-size 24 | pbcopy
}

function mdless {
    pandoc -s -f markdown -t man $1 | groff -T utf8 -man | less
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

#RVM goodies
# rbenv goodies
#if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
# try without rehashing on every shell startup
if which rbenv > /dev/null; then eval "$(rbenv init - --no-rehash)"; fi

export PATH="/Users/gvaughn/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Local host-only additions
[[ -s ~/.local_bash_profile ]] && source ~/.local_bash_profile

# slackbot prank
# HUBOT_SLACK_TOKEN=blahblahblah
# function botpost () {
#   curl -X POST -F token=$HUBOT_SLACK_TOKEN -F channel="$1" -F text="$2" https://slack.com/api/chat.postMessage
# }

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
