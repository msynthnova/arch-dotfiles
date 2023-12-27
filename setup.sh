#!/bin/bash

cp .tmux.conf ~/
cp .zshrc ~/
cp kitty.conf ~/.config/kitty/
cp hyprland.conf ~/.config/hypr

git config --global credential.helper store
git config --global user.name "Felix"
git config --global user.email "kcong.nguyen@icloud.com"
