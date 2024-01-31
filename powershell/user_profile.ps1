# Aliases
Set-Alias guidgen uuidgen
Set-Alias paste Get-Clipboard
Set-Alias clip Set-Clipboard
Set-Alias vi nvim
Set-Alias vim nvim

$homeFolder = [environment]::GetFolderPath("UserProfile")
$documentsFolder = [environment]::GetFolderPath("MyDocuments")
$sourceRoot = "$($homeFolder)/source"
$repoRoot = "$($sourceRoot)/repos"
$scriptsRoot = "$($repoRoot)/scripts"
$localScriptsRoot = "$($documentsFolder)/localscripts"
$gitBinRoot = "C:\Program Files\Git\usr\bin"
$Env:RepoRoot = $repoRoot

if (Test-Path -Path $gitBinRoot) {
    Write-Host "Add Git bin tools"
    Set-Alias tig "$($gitBinRoot)\tig.exe"
    Set-Alias grep "$($gitBinRoot)\grep.exe"
    Set-Alias less "$($gitBinRoot)\less.exe"
    Set-Alias tail "$($gitBinRoot)\tail.exe"
}

if (Test-Path -Path "$env:USERPROFILE/.azure-kubelogin") {
    Write-Host "Add kubelogin"
    $env:path += ";$env:USERPROFILE/.azure-kubelogin;"
}

if (Test-Path -Path $localScriptsRoot) {
    #
    # Weird place for temporary/company specific scripts, but most of the time 
    # this folder is sync'ed/backed up in enterprise environments so it does 
    # not (or can't) go into a git repo
    #
    Write-Host "Add local scripts"
    $env:path += ";$($localScriptsRoot);"
}

if (Test-Path -Path $scriptsRoot) {
    Write-Host "Adding scripts"
    $env:path += ";$($scriptsRoot)"
}

if (Test-Path -Path "$($homeFolder)/.nuget/plugins/netcore/CredentialProvider.Microsoft") {
    Write-Host ".NET Credential Provider"
}
else {
    Write-Host "Missing .NET Credential Provider"
    Write-Host "Check https://github.com/Microsoft/artifacts-credprovider"
}

# Prompt
Import-Module -Name Terminal-Icons
oh-my-posh --init --shell pwsh --config "$($repoRoot)/dotfiles-windows/ohmpsh/posh.json" | Invoke-Expression

# PSReadline Config
# (Snippets from https://gist.github.com/shanselman/25f5550ad186189e0e68916c6d7f44c3)
if ($host.Name -eq 'ConsoleHost') {
    Import-Module PSReadLine
}

Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-PSReadLineKeyHandler -Key F7 `
    -BriefDescription History `
    -LongDescription 'Show command history' `
    -ScriptBlock {
    $pattern = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$pattern, [ref]$null)
    if ($pattern) {
        $pattern = [regex]::Escape($pattern)
    }

    $history = [System.Collections.ArrayList]@(
        $last = ''
        $lines = ''
        foreach ($line in [System.IO.File]::ReadLines((Get-PSReadLineOption).HistorySavePath)) {
            if ($line.EndsWith('`')) {
                $line = $line.Substring(0, $line.Length - 1)
                $lines = if ($lines) {
                    "$lines`n$line"
                }
                else {
                    $line
                }
                continue
            }

            if ($lines) {
                $line = "$lines`n$line"
                $lines = ''
            }

            if (($line -cne $last) -and (!$pattern -or ($line -match $pattern))) {
                $last = $line
                $line
            }
        }
    )
    $history.Reverse()

    $command = $history | Out-GridView -Title History -PassThru
    if ($command) {
        [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert(($command -join "`n"))
    }
}

Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

# Utility Modules
Import-Module -Name DockerCompletion

# Utility functions
function touch() {
    New-Item -ItemType File -Name $args[0]
}

function which() {
    $command = (Get-Command $args[0] -ErrorAction SilentlyContinue)
    if ($null -eq $command) {
        Write-Host "Could not find $($args[0])"
        return
    }

    $command.Path
}

function printvars() {
    Get-ChildItem env:* | sort-object name
}

function repos() {
    Set-Location $Env:RepoRoot
    Get-ChildItem
}

function editHistory() {
    code (Get-PSReadlineOption).HistorySavePath
}

function uuidgen() {
    param (
        [Parameter()] [int] $count = 1
    )

    for ($i = 0; $i -lt $count; $i++) {
        [guid]::NewGuid().Guid
    }
}

# In $PROFILE:
# . $env:USERPROFILE\.config\powershell\user_profile.ps1

# Fonts
# Caskaydia Cove Nerd Font from https://www.nerdfonts.com/font-downloads
# curl -L -o font.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip

# Terminal Font & Color
#
# "profiles": 
# {
#     "defaults": 
#     {
#         "background": "#132738",
#         "cursorHeight": 4,
#         "cursorShape": "vintage",
#         "font": 
#         {
#             "face": "CaskaydiaCove NF"
#         }
#     }

# Powershell Modules to install
#
# Install-Module -Name Terminal-Icons -Repository PSGallery
# Install-Module -Name DockerCompletion -Scope CurrentUser
# Install-Module PSReadLine -AllowPrerelease -Force
# Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force
# Install-Module -Name powershell-yaml -Force
# Install-Module -Name MSAL.PS

# NPM stuff
# npm install azure-functions-core-tools -g

# Az extensions/Other commandline stuff
# az aks install-cli
# az extension add --name azure-devops

# Other stuff to install
#
# winget install -e --id Git.Git
# winget install -e --id JanDeDobbeleer.OhMyPosh
# winget install -e --id Microsoft.AzureCLI
# winget install -e --id OpenJS.NodeJS.LTS
# winget install -e --id Microsoft.VisualStudioCode
# winget install -e --id Microsoft.VisualStudio.2022.Enterprise
# winget install -e --id Microsoft.VisualStudio.2022.Professional
# winget install -e --id Pulumi.Pulumi
# winget install -e --id Mirantis.Lens
# winget install -e --id Yarn.Yarn
# winget install -e --id Docker.DockerDesktop
# winget install -e --id Microsoft.AzureStorageExplorer
# winget install -e --id Microsoft.SQLServerManagementStudio
# winget install -e --id Insomnia.Insomnia
# winget install -e --id Neovim.Neovim
# winget install -e --id Hugo.Hugo.Extended
# winget install -e --id 7zip.7zip
# winget install Dapr.CLI

# VSCode Extensions
# code --install-extension ms-vscode.hexeditor
# code --install-extension esbenp.prettier-vscode
# code --install-extension ms-vscode.powershell
# code --install-extension octref.vetur
# code --install-extension hediet.vscode-drawio
# code --install-extension ms-azuretools.vscode-docker
# code --install-extension ms-azuretools.vscode-bicep
# code --install-extension redhat.vscode-yaml
# code --install-extension sdras.night-owl
# code --install-extension johnsoncodehk.volar
# code --install-extension WallabyJs.quokka-vscode

# Add Az Devops Artifact feed
# - Generate a PAT
# - Run:
#   dotnet nuget update source [SOURCENAME] --source [FEEDURL] --username [EMAIL_USERNAME] --password [PAT]

# Add Az Devops defaults
# az devops configure --defaults "organization=https://dev.azure.com/something" "project=SomeProject"
# az devops login

# Git Config
# - Automatically set the upstream:
#   git config --global push.default current
# - Commit info
#   git config --global user.name "Your Name"
#   git config --global user.email you@example.com
# - Set default branch name
#   git config --global init.defaultBranch main
# - Single line logging with some colors (git log --pretty=single-line)
#   git config --global pretty.single-line "%Cred%h %Cgreen%cI %Creset%s %C(bold blue)<%cn>%Creset"

# Set Azure Subscription
# - az login
# - set-devaccount.ps1 [ACCOUNTNAME] (run without account name to see which ones are available)
