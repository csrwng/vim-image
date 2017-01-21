FROM centos:centos7

RUN  yum -y install git bash-completion tar wget vim gcc-c++ make \
           openssl-devel python-devel python3-devel \
           rsync 
           
RUN mkdir /home/default && chmod 777 /home/default
ENV HOME=/home/default

RUN bash -c "cd $HOME && git clone https://github.com/magicmonty/bash-git-prompt.git .bash-git-prompt --depth=1"
ENV  LANG=en_US.utf8 \
     LC_ALL=en_US.utf8 \
     TERM=xterm-256color \
     TZ="America/New_York" \
     HOME=/root \
     GIT_PROMPT_ONLY_IN_REPO=1 \
     PATH=$HOME/bin:/common/bin \
     PS1="\h:\w > "
COPY bashrc $HOME/.bashrc
COPY vimrc $HOME/.vimrc
COPY gitconfig $HOME/.gitconfig
COPY gitignore_global $HOME/.gitignore_global
RUN  chmod -R 777 $HOME
RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
RUN  /bin/bash -c "mkdir -p /data && vim +PluginInstall +quitall &> /dev/null || echo Done"

CMD ["/bin/bash", "-c", "while(true); do date; sleep 300; done"]

WORKDIR /data
