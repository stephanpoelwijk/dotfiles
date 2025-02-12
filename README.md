# dotfiles

Collection of Powershell, VSCode and Terminal configuration files and
information for a new machine setup.

# Additional configuration

Below there is some additional setup that has not been scripted yet.

## Visual Studio

Extra setting to Ctrl+. our way through constructor parameters and creating
private fields with an underscore.

-   Go to `Tools -> Options -> Text Editor -> C# -> Code Style -> Naming`
-   Add `Naming style` called "Private underscore fields"
-   Add a new specification (with the '+')
    -   Select `Private or internal field` as the specification
    -   Select `Private underscore fields` for the required style
    -   Set it as a `Suggestion`

## Symlink configuration

```
ln -s ~/repos/dotfiles/nvim ~/.config/nvim
ln -s ~/repos/dotfiles/powershell ~/.config/powershell
ln -s ~/repos/dotfiles/oh-my-posh ~/.config/oh-my-posh
ln -s ~/repos/dotfiles/tmux ~/.config/tmux
ln -s ~/repos/dotfiles/.prettierrc ~/.prettierrc
ln -s ~/repos/dotfiles/.pylintrc ~/.pylintrc
```

Link Obsidian vaults to a subfolder of to `~/vaults`.

## Dotnet stuff

-   Create a self-signed certificate with `dotnet dev-certs https --trust`
-   [HTTPS needs to be before HTTP in the launchsettings](https://github.com/dotnet/runtime/issues/27132)
    for things to work

## XCode Stuff

-   Header template macros go into `~/Library/Developer/Xcode/UserData`

## Misc

-   Neovim plugin configuration mostly comes from
    [here](https://www.josean.com/posts/how-to-setup-neovim-2024)
