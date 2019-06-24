
# Install oh-my-zsh
if [ ! -d "~/.oh-my-zsh" ]; then 
	sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";
fi

# 
brew install python
pip install powerline-status


git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# Setup fonts
# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts

ln -sfnv ~/homedir/zshrc ~/.zshrc

if [ -d ~/.jorbin/.vim ]
    rm -rf ~/.vim
    rm -rf ~/.vimrc

    then
    ln -sfnv ~/.jorbin/.vim ~/.vim
    ln -sfnv ~/.jorbin/.vim/vimrc ~/.vimrc
    cd ~/.vim
    mkdir tmp 
    git submodule init
    git submodule update
    cd $CURRENTDIR
fi
