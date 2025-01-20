#!/bin/bash 
read -p 'neovim will be installed into this directory, continue? '
wget https://github.com/neovim/neovim/releases/download/v0.10.3/nvim-linux64.tar.gz
tar -xzvf ./nvim-linux64.tar.gz
echo "export PATH=$PATH:$(pwd)/nvim-linux64/bin/nvim"
source ~/.bashrc
