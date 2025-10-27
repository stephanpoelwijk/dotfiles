#!/bin/sh

# This script contains a bunch of random install instructions. It serves
# more as a reminder for me of what to install. There is no way to test
# it because I only have one Mac :p


brew install --formulae azure-cli \
    borders \
    ffmpeg \
    fzf \
    git-filter-repo \
    go \
    graphviz \
    hugo \
    imagemagick \
    lazydocker \
    lazygit \
    libpq \
    mise \
    neovim \
    node \
    oh-my-posh \
    openjdk \
    orc-tools \
    p7zip \
    patchutils \
    pgcli \
    powershell \
    prettier \
    python \
    ripgrep \
    tmux \
    tuist \
    wget \
    xcode-build-server \
    yarn \
    yazi

brew install --casks aerospace \
    anaconda \
    devpod \
    devtoys \
    dotnet-sdk \
    ghostty \
    gimp \
    obsidian \
    pinta \
    wezterm

cp ./xcode/IDETemplateMacros.plist ~/Library/Developer/Xcode/UserData

