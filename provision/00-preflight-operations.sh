#!/usr/bin/env bash

# enables ssh agent forwarding during provision
SSH_FIX_FILE="/etc/sudoers.d/root_ssh_agent"
if [ ! -f  $SSH_FIX_FILE ]
    then
    echo "Defaults env_keep += \"SSH_AUTH_SOCK\"" > $SSH_FIX_FILE
    chmod 0440 $SSH_FIX_FILE
fi

# installs everyday utilities
apt-get update
apt-get install -y unace p7zip-rar sharutils rar unrar arj lunzip lzip htop tmux build-essential libtool libcurl3 curl tcl mercurial git vim vim-scripts vim-addon-manager default-jdk

# git config
git config --global core.filemode false

# vim config
touch /root/.vimrc
touch /home/ubuntu/.vimrc

cat <<'EOF' | tee /root/.vimrc | /home/ubuntu/.vimrc
set number
set nowrap
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set splitright
set splitbelow
set encoding=utf-8
set fileencoding=utf-8
set hlsearch
EOF

chown ubuntu:ubuntu /home/ubuntu/.vimrc
