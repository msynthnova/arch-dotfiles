#!/bin/bash

cp .tmux.conf .zshrc ~/
cp kitty.conf ~/.config/kitty/
cp hyprland.conf hyprpaper.conf ~/.config/hypr/
cp -r media ~/.config/hypr/
cp config style.css ~/.config/waybar

git config --global credential.helper store
git config --global user.name "Felix"
git config --global user.email "kcong.nguyen@icloud.com"
git config --global init.defaultBranch main
