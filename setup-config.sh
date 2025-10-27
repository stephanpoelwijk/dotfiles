#!/bin/sh

# Set up all the dotfiles stuff
ln -sf ./nvim ~/.config/nvim
ln -sf ./powershell ~/.config/powershell
ln -sf ./oh-my-posh ~/.config/oh-my-posh
ln -sf ./tmux ~/.config/tmux
ln -sf ./aerospace ~/.config/aerospace
ln -sf ./ghostty ~/.config/ghostty
ln -sf ./.prettierrc ~/.prettierrc
ln -sf ./.pylintrc ~/.pylintrc
ln -sf ./wezterm ~/.config/wezterm

# Trust self signed certificates
dotnet dev-certs https --trust

