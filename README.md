# dotfile

Personal dotfiles for macOS development environment.

## Overview

Configuration files for terminal, editor, and window management tools. Managed with symlinks for easy setup across machines.

## Contents

| Directory | Tool | Config File |
|-----------|------|-------------|
| `aerospace/` | AeroSpace | `aerospace.toml` |
| `alacritty/` | Alacritty | `alacritty.toml` |
| `git/` | Git | `.gitconfig` |
| `nvim/` | Neovim | `init.lua` |
| `tmux/` | Tmux | `.tmux.conf` |
| `tmuxinator/` | Tmuxinator | `*.yml` |
| `zsh/` | Zsh | `.zshrc` |

## Installation

### Prerequisites

- macOS
- Homebrew
- Git

### Install Tools

```bash
brew install neovim tmux zsh alacritty
brew install --cask aerospace
gem install tmuxinator
```

### Symlink Configs

```bash
# Zsh
ln -sf ~/dotfile/zsh/.zshrc ~/.zshrc

# Git
ln -sf ~/dotfile/git/.gitconfig ~/.gitconfig

# Neovim
ln -sf ~/dotfile/nvim ~/.config/nvim

# Tmux
ln -sf ~/dotfile/tmux/.tmux.conf ~/.tmux.conf

# Tmuxinator
ln -sf ~/dotfile/tmuxinator ~/.config/tmuxinator

# Alacritty
ln -sf ~/dotfile/alacritty ~/.config/alacritty

# AeroSpace
ln -sf ~/dotfile/aerospace/aerospace.toml ~/.aerospace.toml
```

## Neovim

Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management.

### LSP Support

- Lua
- TypeScript/JavaScript
- Elixir
- Go
- Python
- Swift
- C/C++
- JSON

## Tmuxinator Projects

| Template | Description |
|----------|-------------|
| `dotfile` | Edit dotfiles |
| `wepay` | WePay development |
| `emola` | Emola project |
| `totp` | TOTP project |

Start a project:

```bash
mux start <project>
```

## License

MIT
