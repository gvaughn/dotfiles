#!/bin/sh

utils=(
  bash-completion
  git
  ctags
  neovim
  httpie
  reattach-to-user-namespace
  wemux
  hub
  keybase
  heroku
  jq
  ripgrep
  asdf
)

brew install ${utils[@]}
brew install caskroom/cask/brew-cask
#emcacs port support
# brew tap raiwaycat/emacsmacport

# Jared's Apps
# apps=(
#   alfred
#   dropbox
#   google-chrome
#   qlcolorcode
#   screenflick
#   slack
#   transmit
#   appcleaner
#   firefox
#   hazel
#   qlmarkdown
#   seil
#   spotify
#   vagrant
#   arq
#   flash
#   iterm2
#   qlprettypatch
#   shiori
#   sublime-text3
#   virtualbox
#   atom
#   flux
#   mailbox
#   qlstephen
#   sketch
#   tower
#   vlc
#   cloudup
#   nvalt
#   quicklook-json
#   skype
#   transmission
# )
apps=(
  quicksilver
  dropbox
  google-chrome
  slack
  iterm2
  flux
  nvalt
  quicklook-json
  viscosity
  limechat
  mattr-slate
  meteorologist
  day-o
  cyberduck
  macdown
  licecap
  itsycal
  #emacs-mac
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}

# brew tap caskroom/fonts
# brew cask install font-fira-code
brew tap homebrew/cask-fonts
brew cask install font-jetbrains-mono-powerline

# Let's get rbenv set up
mkdir -p ~/.rbenv/plugins/
cd ~/.rbenv/plugins/
git clone https://github.com/sstephenson/ruby-build.git
git clone https://github.com/ianheggie/rbenv-binstubs.git
git clone https://github.com/sstephenson/rbenv-gem-rehash.git
git clone https://github.com/sstephenson/rbenv-default-gems.git
ln -s ~/dotfiles/default-gems ~/.rbenv/default-gems

# cups at http://localhost:631
cupsctl WebInterface=yes
