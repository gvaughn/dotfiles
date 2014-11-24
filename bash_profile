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

# brew install bash-completion for this to work
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# History: don't store duplicates
export HISTCONTROL=erasedups
# History: 10,000 entries
export HISTSIZE=10000
# e: exit without q at end, r: color codes, X: leave results in buffer
export LESS="-erX"

# control Terminal.app tab names
function tabname {
  printf "\e]1;$1\a"
}
 
function winname {
  printf "\e]2;$1\a"
}

export RUBYOPT=-Itest # so we can just invoke ruby test/unit/foo.rb

export PATH=/usr/local/bin:/usr/local/sbin:~/bin:/usr/local/mysql/bin:$PATH
# so bundle open {gemname} works
export BUNDLER_EDITOR=v

# manage JVM now that I'm doing some clojure
function setjdk() {
  if [ $# -ne 0 ]; then
    removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
    if [ -n "${JAVA_HOME+x}" ]; then
      removeFromPath $JAVA_HOME
    fi
    export JAVA_HOME=`/usr/libexec/java_home -v $@`
    export PATH=$JAVA_HOME/bin:$PATH
  fi
}
function removeFromPath() {
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}
setjdk 1.7

alias vim='mvim -v'
alias ls='ls -aFGh'
alias ll='ls -lah'
alias flush='echo "flush_all" | nc localhost 11211'
alias raket='USE_TURN=true time rake | grep -v PASS; growlnotify -s -m "Rake tests: DONE"'
alias update_submodules='git pull --recurse-submodules && git submodule update'
alias mdns_restart='sudo killall -HUP mDNSResponder'
alias gemkill='gem list | cut -d" " -f1 | xargs gem uninstall -aIx'
alias bl='bundle --local'
alias b='(bundle check || bundle --local --jobs=4 || bundle --jobs=4)'
alias ri='ri -f ansi'
alias rc='test -e script/console && bundle exec script/console "$@" || bundle exec rails console "$@"'
alias iex='rlwrap -H "/Users/enduser/.iex_history" -c -D 2 -r iex'
alias port_holder='sudo lsof -i -P | grep -i "listen"'
alias pryr='pry -r ./config/environment.rb'
alias nginx_start='launchctl start homebrew.mxcl.nginx'
alias resqueweb='bundle exec resque-web'
alias :q=exit

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
#RVM goodies
# rbenv goodies
#if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
# try without rehashing on every shell startup
if which rbenv > /dev/null; then eval "$(rbenv init - --no-rehash)"; fi

# Local host-only additions
[[ -s ~/.local_bash_profile ]] && source ~/.local_bash_profile
