# dotfiles

Personal macOS development environment configuration.

## Prerequisites

- macOS
- [Homebrew](https://brew.sh)
- [GNU Stow](https://www.gnu.org/software/stow/)

## Installation

Install packages:
```bash
brew bundle install
```

Apply dotfiles:
```bash
cd ~/
stow dotfiles
```

Reload shell:
```bash
source ~/.zshrc
```

## What's Included

**Window Management**
- yabai - Tiling window manager
- skhd - Keyboard shortcuts
- Sketchybar - Custom menu bar
- borders - Window border styling

**Terminal**
- Alacritty - GPU-accelerated terminal
- tmux - Terminal multiplexer (prefix: Ctrl+a)
- zsh - Shell with Oh My Zsh

**Editor**
- Neovim - LazyVim configuration

**Tools**
- Git, lazygit, lazydocker
- Node (nvm), pnpm, .NET, Python, Rust, Go
- fd, ripgrep, btop, ranger, zoxide

## Key Commands

**Window Management**
- `cmd+h/j/k/l` - Focus window
- `cmd+1-9` - Switch space
- `shift+cmd+1-9` - Send window to space
- `cmd+return` - Open terminal

**tmux**
- `Ctrl+a` - Prefix
- `prefix+[` - Copy mode
- `prefix+r` - Reload config

## Notes

- Secrets go in `~/.secrets.sh` (gitignored)
- See CLAUDE.md for detailed documentation
