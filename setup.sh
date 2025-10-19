# Set up all the dotfiles stuff
ln -s ./nvim ~/.config/nvim
ln -s ./powershell ~/.config/powershell
ln -s ./oh-my-posh ~/.config/oh-my-posh
ln -s ./tmux ~/.config/tmux
ln -s ./aerospace ~/.config/aerospace
ln -s ./ghostty ~/.config/ghostty
ln -s ./.prettierrc ~/.prettierrc
ln -s ./.pylintrc ~/.pylintrc
ln -s ./wezterm ~/.config/wezterm

# Trust self signed certificates
dotnet dev-certs https --trust

# Template for new file in Xcode
cp ./xcode/IDETemplateMacros.plist ~/Library/Developer/Xcode/UserData
