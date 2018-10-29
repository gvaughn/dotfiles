##Installation
```
    cd ~
    git clone git://github.com/gvaughn/dotfiles.git
    ln -s ~/dotfiles/bash_profile ~/.bash_profile
    ln -s ~/dotfiles/gitconfig ~/.gitconfig
    ln -s ~/dotfiles/gitignore_global ~/.gitignore_global
    ln -s ~/dotfiles/irbrc ~/.irbrc
    ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
    ln -s ~/dotfiles/ctags ~/.ctags
    ln -s ~/dotfiles/bin ~/bin
    ln -s ~/dotfiles/config/nvim/init.vim ~/.config/nvim/init.vim
    ln -s ~/dotfiles/config/ripgrep ~/.config/ripgrep
    dotfiles/brew_installs.sh
    dotfiles/extremesetup.sh
```

## TODO
consider a bare git repo with explicit workspace setting of $HOME to avoid symlinking
https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/

`brew bundle dump` and `brew bundle` via a Brewfile (which can handle casks and font casks)
https://robots.thoughtbot.com/brewfile-a-gemfile-but-for-homebrew
