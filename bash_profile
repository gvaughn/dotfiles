#stop hiding Library folder, Apple
chflags nohidden ~/Library
# case insensitive bash filename completion
shopt -s nocaseglob

# git goodies
PS1='\[\033[G\][\u@\h \W$(__git_ps1 " (%s)")]\$ '
#export GIT_AUTHOR_EMAIL=greg.vaughn@livingsocial.com

export GREP_OPTIONS='--color=auto'
export LESS='-iMRXFfx4'
export VISUAL='mvim'
export EDITOR='vim'

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

# This resolves issues install the mysql, postgres, and other gems with native non universal binary extensions
export ARCHFLAGS='-arch x86_64'

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

# REE for LivingSocial
export RUBY_HEAP_FREE_MIN=1024
export RUBY_HEAP_MIN_SLOTS=4000000
export RUBY_HEAP_SLOTS_INCREMENT=250000
export RUBY_GC_MALLOC_LIMIT=500000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
#export CC=/usr/bin/gcc-4.2 #makes rvm install ree happy
export RUBYOPT=-Itest # so we can just invoke ruby test/unit/foo.rb

export PATH=/usr/local/bin:/usr/local/sbin:~/bin:/usr/local/mysql/bin:$PATH
# so bundle open {gemname} works
export BUNDLER_EDITOR=v

# Don't remember what these two below were for, but trying them off for now
#export LDFLAGS=-L/usr/local/Cellar/libxml2/2.7.8/lib
#export CPPFLAGS=-I/usr/local/Cellar/libxml2/2.7.8/include

alias ls='ls -aFGh'
alias ll='ls -lah'
alias mark_live_deals='RAILS_ENV=development script/offline_tasks.rb mark_live_deals'
alias dbup='DB_ENCRYPTION_KEY=hungry2601 DB_PASSWORD=your_password bin/rake db:reload && say "db finished"'
#Opening the VPN dialog from Terminal; kills racoon just to be sure.
#    Note: from @andy.atkinson to brew install proctools so that pgrep works
alias openvpn="/usr/local/bin/pgrep racoon | xargs sudo kill -9; osascript ~/Documents/applescripts/openvpn.scpt"
alias flush='echo "flush_all" | nc localhost 11211'
alias raket='USE_TURN=true time rake | grep -v PASS; growlnotify -s -m "Rake tests: DONE"'
alias update_submodules='git pull --recurse-submodules && git submodule update'
#alias foreman_no_web="foreman start -c $(ruby -e 'print (File.read("./Procfile").scan(/^(\w+):/).flatten - ["web"]).join("=1,") + "=1"')"
alias pow_restart='touch ~/.pow/ls/tmp/restart.txt'
alias mdns_restart='sudo killall -HUP mDNSResponder'
alias gemkill='gem list | cut -d" " -f1 | xargs gem uninstall -aIx'

#lestrade myqa settings
export MYQA_INSTANCE=492
export MYQA_API_KEY=jUqIWrrboIQnXngk2S8b

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
