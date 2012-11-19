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
PS1='\[\033[G\][\u@\h \W$(__git_ps1 " (%s)")]\$ '
#export GIT_AUTHOR_EMAIL=greg.vaughn@livingsocial.com
# let's use hub for all my git needs
eval "$(hub alias -s)"

export GREP_OPTIONS='--color=auto'
export LESS='-iMRXFfx4'
export VISUAL='mvim'
export EDITOR='vim'

# make man colorful
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[1;31m'        # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;33;5;146m' # begin underline

# brew install bash-completion for this to work
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

#
# Call git checkout and load rvmrc
# useful when diff branches have diff rubies/gemsets
#
#gco()
#{
#  git checkout $*
#  if [[ -s .rvmrc ]] ; then
#    unset rvm_rvmrc_cwd
#    cd .
#  fi
#}

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

#export CC=/usr/bin/gcc-4.2 #makes rvm install ree happy
export RUBYOPT=-Itest # so we can just invoke ruby test/unit/foo.rb

export PATH=/usr/local/bin:/usr/local/sbin:~/bin:/usr/local/mysql/bin:$PATH
# so bundle open {gemname} works
export BUNDLER_EDITOR=v

alias vim='mvim -v'
alias ls='ls -aFGh'
alias ll='ls -lah'
alias flush='echo "flush_all" | nc localhost 11211'
alias raket='USE_TURN=true time rake | grep -v PASS; growlnotify -s -m "Rake tests: DONE"'
alias update_submodules='git pull --recurse-submodules && git submodule update'
#alias foreman_no_web="foreman start -c $(ruby -e 'print (File.read("./Procfile").scan(/^(\w+):/).flatten - ["web"]).join("=1,") + "=1"')"
alias pow_restart='touch ~/.pow/ls/tmp/restart.txt'
alias mdns_restart='sudo killall -HUP mDNSResponder'
alias gemkill='gem list | cut -d" " -f1 | xargs gem uninstall -aIx'
alias bl='bundle --local'
alias ri='ri -f ansi'

# no need to prefix bin/rake etc. in a bundle'd project
BUNDLED_COMMANDS="foreman rackup rails rake rspec ruby shotgun spec watchr nesta cap"

## Functions

bundler-installed()
{
    which bundle > /dev/null 2>&1
}

within-bundled-project()
{
    local dir="$(pwd)"
    while [ "$(dirname $dir)" != "/" ]; do
        [ -f "$dir/Gemfile" ] && return
        dir="$(dirname $dir)"
    done
    false
}

run-with-bundler()
{
    local command="$1"
    shift
    if bundler-installed && within-bundled-project; then
        bundle exec $command $*
    else
        $command $*
    fi
}

## Main program

for CMD in $BUNDLED_COMMANDS; do
    alias $CMD="run-with-bundler $CMD"
done

#RVM goodies
#[[ -s /Users/enduser/.rvm/scripts/rvm ]] && source /Users/enduser/.rvm/scripts/rvm  # This loads RVM into a shell session.
# rbenv goodies
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Local host-only additions
[[ -s ~/.local_bash_profile ]] && source ~/.local_bash_profile
