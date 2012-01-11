# git goodies
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

# brew install bash-completion for this to work
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

#
# Call git checkout and load rvmrc
# useful when diff branches have diff rubies/gemsets
#
gco()
{
  git checkout $*
  if [[ -s .rvmrc ]] ; then
    unset rvm_rvmrc_cwd
    cd .
  fi
}

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
export CC=/usr/bin/gcc-4.2 #makes rvm install ree happy
export RUBYOPT=-Itest # so we can just invoke ruby test/unit/foo.rb

export PATH=/usr/local/bin:~/bin:/usr/local/mysql/bin:$PATH
# so bundle open {gemname} works
export BUNDLER_EDITOR=v

export LDFLAGS=-L/usr/local/Cellar/libxml2/2.7.8/lib
export CPPFLAGS=-I/usr/local/Cellar/libxml2/2.7.8/include

alias ls='ls -aFGh'
alias ll='ls -lah'
alias mark_live_deals='RAILS_ENV=development script/offline_tasks.rb mark_live_deals'
alias dbup='DB_ENCRYPTION_KEY=hungry2601 DB_PASSWORD=your_password rake db:reload && say "db finished"'
#Opening the VPN dialog from Terminal; kills racoon just to be sure.
#    Note: from @andy.atkinson to brew install proctools so that pgrep works
alias openvpn="/usr/local/bin/pgrep racoon | xargs sudo kill -9; osascript ~/Documents/applescripts/openvpn.scpt"
alias flush='echo "flush_all" | nc localhost 11211'

# Nice ideas, but don't handle collab branches or any non-deals app.
function new_pr { open http://svn.livingsocial.com/$(git config --get github.user)/deals/pull/new/$(git symbolic-ref head| sed -e 's/.*\///g'); }

#lestrade myqa settings
export MYQA_INSTANCE=325
export MYQA_API_KEY=jUqIWrrboIQnXngk2S8b

#RVM goodies
[[ -s /Users/enduser/.rvm/scripts/rvm ]] && source /Users/enduser/.rvm/scripts/rvm  # This loads RVM into a shell session.
