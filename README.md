##Installation
    cd ~
    git clone git://github.com/gvaughn/dotfiles.git
    ln -s ~/dotfiles/vim ~/.vim
    ln -s ~/dotfiles/vim/vimrc ~/.vimrc
    ln -s ~/dotfiles/vim/gvimrc ~/.gvimrc
    ln -s ~/dotfiles/bash_profile ~/.bash_profile
    ln -s ~/dotfiles/gitconfig ~/.gitconfig
    ln -s ~/dotfiles/gitignore_global ~/.gitignore_global
    ln -s ~/dotfiles/irbrc ~/.irbrc
    ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
    ln -s ~/dotfiles/bin ~/bin
    vim -u bundles.vim +BundleInstall +q

