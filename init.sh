# /bin/sh

REPOPATH=~/myconfig

rm -rf ~/.bashrc
ln -s $REPOPATH/.bashrc ~/.bashrc

rm -rf ~/.vim
ln -s $REPOPATH/.vim ~/.vim

rm -rf ~/.vimrc
ln -s $REPOPATH/.vimrc ~/.vimrc

rm -rf ~/.screenrc
ln -s $REPOPATH/.screenrc ~/.screenrc

rm -rf ~/.gitconfig
ln -s $REPOPATH/.gitconfig ~/.gitconfig

