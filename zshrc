if type brew &>/dev/null
then
  # brew completions
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit

. $(brew --prefix asdf)/libexec/asdf.sh
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Note: profile contains an unalias of zprezto g=git alias
# so my function g works
. ~/.profile
