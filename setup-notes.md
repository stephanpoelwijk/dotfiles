```
sudo apt install nvim
sudo apt install ripgrep
sudo apt install make
sudo apt install gcc
sudo apt install unzip

lazygit


# Add unstable feed to allow keymaps
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim


https://vi.stackexchange.com/questions/41474/lazyvim-removal-uninstall-guidance
In case of trouble, remove stuff in ~/.local/share/nvim


installation of plugins comes from:
https://www.josean.com/posts/how-to-setup-neovim-2024

Symlink things to repo:

ln -s ~/repos/dotfiles/nvim ~/.config/nvim
ln -s ~/repos/dotfiles-windows/powershell ~/.config/powershell

Ensure this is in the path:
$(/opt/homebrew/bin/brew shellenv) | Invoke-Expression


## dotnet stuff
dotnet dev-certs https --trust

### Launchsettings need some work
https://github.com/dotnet/runtime/issues/27132

```
