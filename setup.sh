#!/bin/bash

cp .tmux.conf .zshrc ~/
cp kitty.conf ~/.config/kitty/
cp media/wallhaven.jpg config ~/.config/sway/
cp -r fonts ~/.local/share

git config --global credential.helper store
git config --global user.name "Felix"
git config --global user.email "kcong.nguyen@icloud.com"
git config --global init.defaultBranch main
