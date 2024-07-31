# DotFiles-Windows

Collection of Powershell, VSCode and Terminal configuration files and information for a new machine setup.

# Additional configuration

Below there is some additional setup that has not been scripted yet.

## Visual Studio

Extra setting to Ctrl+. our way through constructor parameters and creating private fields with an underscore.

- Go to `Tools -> Options -> Text Editor -> C# -> Code Style -> Naming`
- Add `Naming style` called "Private underscore fields"
- Add a new specification (with the '+')
  - Select `Private or internal field` as the specification
  - Select `Private underscore fields` for the required style
  - Set it as a `Suggestion`

## Symlink configuration

ln -s ~/repos/dotfiles-windows/nvim ~/.config/nvim
ln -s ~/repos/dotfiles-windows/powershell ~/.config/powershell

## Dotnet stuff

- Create a self-signed certificate with `dotnet dev-certs https --trust`
- [HTTPS needs to be before HTTP in the launchsettings](https://github.com/dotnet/runtime/issues/27132) for things to work

## Powershell Mac

- Ensure this is in the path:
  `$(/opt/homebrew/bin/brew shellenv) | Invoke-Expression`

## Misc

- Neovim plugin configuration mostly comes from [here](https://www.josean.com/posts/how-to-setup-neovim-2024)
