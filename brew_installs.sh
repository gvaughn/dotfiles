#!/bin/sh

utils=(
  bash-completion
  git
  diff-so-fancy
  ctags
  neovim
  httpie
  reattach-to-user-namespace
  wemux
  hub
  keybase
  jq
  ripgrep
  asdf
  fzf
)

brew install ${utils[@]}

apps=(
#  quicksilver
  dropbox
  google-chrome
  slack
#  iterm2
#  flux
  nvalt
#  quicklook-json
#  viscosity
#  limechat
#  mattr-slate
  meteorologist
#  day-o
#  cyberduck
  macdown
#  licecap
#  itsycal
  #emacs-mac
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps..."
brew tap homebrew/cask
brew install --appdir="/Applications" ${apps[@]}

# brew install font-fira-code
brew tap homebrew/cask-fonts
brew install font-jetbrains-mono-nerd-font

# Let's get rbenv set up
# mkdir -p ~/.rbenv/plugins/
# cd ~/.rbenv/plugins/
# git clone https://github.com/sstephenson/ruby-build.git
# git clone https://github.com/ianheggie/rbenv-binstubs.git
# git clone https://github.com/sstephenson/rbenv-gem-rehash.git
# git clone https://github.com/sstephenson/rbenv-default-gems.git
# ln -s ~/dotfiles/default-gems ~/.rbenv/default-gems

# cups at http://localhost:631
cupsctl WebInterface=yes
