# /bin/sh

REPOPATH=~/myconfig

rm -rf ~/.bashrc
ln -s $REPOPATH/.bashrc ~/.bashrc

#rm -rf ~/.vim
#ln -s $REPOPATH/.vim ~/.vim

#rm -rf ~/.vimrc
#ln -s $REPOPATH/.vimrc ~/.vimrc

#rm -rf ~/.screenrc
#ln -s $REPOPATH/.screenrc ~/.screenrc

rm -rf ~/.gitconfig
ln -s $REPOPATH/.gitconfig ~/.gitconfig

rm -rf ~/.tmux.conf
ln -s $REPOPATH/.tmux.conf ~/.tmux.conf

rm -rf ~/.termcap
ln -s $REPOPATH/.termcap ~/.termcap

# 对spf13还有这几个调整
# 1. .vimrc. ctrlp unlet 变量 g:ctrlp_user_command
# 2. .vimrc. ctrlp 可以加入几个过滤的条件.
# 3. .vimrc.bundles 注释掉 vim-indent-guides

rm -rf ~/.vimrc.local
ln -s $REPOPATH/.vimrc.local ~/.vimrc.local

rm -rf ~/.vimrc.before.local
ln -s $REPOPATH/.vimrc.before.local ~/.vimrc.before.local

