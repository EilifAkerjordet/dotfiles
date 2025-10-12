# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a macOS dotfiles repository containing configuration files for a highly customized development environment. The setup uses GNU Stow for symlink management, with configurations for terminal (Alacritty + tmux + zsh), window management (yabai + skhd), status bar (Sketchybar), and Neovim.

## Repository Structure

```
.
├── .config/              # XDG config directory (stow target: ~/.config/)
│   ├── nvim/            # LazyVim-based Neovim config (see .config/nvim/CLAUDE.md)
│   ├── alacritty/       # Terminal emulator config
│   ├── sketchybar/      # macOS menu bar replacement
│   ├── yabai/           # Tiling window manager
│   ├── skhd/            # Hotkey daemon (uses skhd-zig with command definitions)
│   ├── karabiner/       # Keyboard customization
│   ├── ranger/          # Terminal file manager
│   └── borders/         # Window border styling
├── .tmux/               # tmux plugins and theme
├── .tmux.conf           # tmux configuration
├── .zshrc               # zsh shell configuration
├── Brewfile             # Homebrew package manifest
└── .gitignore           # Secrets and credentials exclusion
```

## Setup and Installation

**Install Homebrew packages**:
```bash
brew bundle install
```

**Apply dotfiles with Stow** (from parent directory):
```bash
cd ~/
stow dotfiles  # Creates symlinks from dotfiles/ to ~/
```

**Reload configurations**:
```bash
# Reload zsh
source ~/.zshrc

# Reload tmux (inside tmux session)
# Press: Ctrl+a then r

# Reload window manager
yabai --restart-service
skhd --reload

# Reload Sketchybar
brew services restart sketchybar
```

## Window Management Architecture

**yabai** (BSP tiling window manager):
- Uses scripting addition (requires sudo/SIP configuration)
- 9 labeled spaces (one through nine)
- BSP layout with 8px padding, 6px gaps
- Focus follows mouse with autoraise
- Float rules for system apps, Spotify, Postman, Finder
- Window borders via `borders` utility (5px, active: blue, inactive: gray)
- Config: `.config/yabai/yabairc`

**skhd** (hotkey daemon using skhd-zig):
- Uses command definitions (`.define`) for reusable yabai commands
- Vim-style navigation: `cmd+h/j/k/l` for focus
- `shift+alt+h/j/k/l` for swap, `shift+cmd+h/j/k/l` for warp
- `cmd+1-9` for space focus, `shift+cmd+1-9` to send window to space
- `cmd+return` launches Alacritty, `alt+n` launches Neovim in Alacritty
- `cmd+alt+s` reloads skhd, `cmd+alt+y` restarts yabai
- Config: `.config/skhd/skhdrc`

**Integration**: yabai handles window layout, skhd handles keybindings, borders adds visual feedback

## Terminal Environment

**tmux**:
- Prefix: `Ctrl+a` (not default `Ctrl+b`)
- TokyoNight theme (`.tmux/tokyonight.conf`)
- Plugins: vim-tmux-navigator, tmux-resurrect, tmux-continuum
- Custom window switching via domino tile Unicode (mapped through Alacritty)
- Vi mode for copy/paste: `prefix+[` enters copy mode, `v` to select, `y` to yank
- Config: `.tmux.conf`

**zsh**:
- Oh My Zsh framework
- Plugins: git, zsh-autosuggestions, zsh-syntax-highlighting, zsh-vi-mode
- zoxide for smart directory jumping
- Sources `~/.secrets.sh` for credentials (gitignored)
- Custom aliases: `n` (dotnet), `v` (nvim), `lg` (lazygit), `ld` (lazydocker), `p` (pnpm)
- Config: `.zshrc`

**Alacritty**:
- Config: `.config/alacritty/alacritty.toml`
- Theme files in `.config/alacritty/themes/`

## Sketchybar Setup

**Architecture**:
- Menu bar replacement with custom plugins
- Dual configuration: laptop vs desktop (different plugins for battery/Spotify placement)
- Plugin scripts in bash, using Sketchybar item API
- Plugins: front_app, clock, timer, weather, volume, current_space, dev_ports, battery (laptop), spotify

**Configuration files**:
- `sketchybarrc` - Symlink to active config
- `sketchybarrc-laptop` - Laptop-specific layout
- `sketchybarrc-desktop` - Desktop-specific layout
- `plugins/` - Shared plugins
- `plugins-laptop/` - Laptop-specific overrides (battery.sh, spotify.sh)
- `plugins-desktop/` - Desktop-specific overrides (spotify.sh)

## Neovim Configuration

See `.config/nvim/CLAUDE.md` for detailed Neovim guidance. Key points:
- LazyVim-based with lazy.nvim plugin manager
- Configured for C#/Blazor (Roslyn + rzls), TypeScript, Svelte, Tailwind
- AI assistance via Avante (Claude Sonnet 4)
- Auto-save with Claude Code diff buffer exclusions
- TokyoNight theme with transparency

## Package Management

**Homebrew** (Brewfile):
- Development tools: neovim, tmux, git, docker (OrbStack), lazygit, lazydocker
- Languages: node, pnpm, python, rust, go, php, ruby, dotnet-sdk
- CLI utilities: fd, ripgrep, btop, htop, ranger, zoxide, stow
- Window management: yabai, skhd-zig, sketchybar, borders, karabiner-elements
- GUI apps: Alacritty, Visual Studio Code, Claude, Arc, Zen, Rider, PyCharm
- Fonts: Nerd Fonts collection (30+ variants)
- Azure tools: azure-cli, azure-functions-core-tools

**Node/JavaScript**:
- nvm for Node version management
- pnpm for package management (alias: `p`)

**.NET**:
- Multiple SDK versions via Homebrew casks
- Alias: `n` for `dotnet` command

## Security Considerations

**Gitignored patterns** (`.gitignore`):
- All secret files: `*.secrets`, `.secrets.sh`, `*.key`, `*.pem`, certificates
- SSH keys: `id_rsa*`, `id_ed25519*`
- Environment files: `.env`, `.env.*` (except `.env.example`)
- API keys: `*api_key*`, `*apikey*`, `*access_token*`, `credentials.json`

**Secrets management**: Shell sources `~/.secrets.sh` for environment variables (line 1 of `.zshrc`)

## Custom Scripts and Paths

**Claude CLI**: Aliased in `.zshrc:121` to `~/.claude/local/claude`

**Claude Docker**: Custom script at `~/claude-docker/src/claude-docker.sh` with scripts in `~/.claude-docker/scripts/` (added to `$PATH` and `$PYTHONPATH`)

**mynav**: Custom navigation tool in `~/.mynav/` (added to `$PATH`)

## Working with This Repository

**Adding new dotfiles**:
1. Place config files in appropriate directory (`.config/` for XDG, root for home files)
2. Use `stow dotfiles` to create symlinks
3. Update this CLAUDE.md if adding new tools/workflows

**Modifying window management**:
- Edit `.config/yabai/yabairc` for layout rules
- Edit `.config/skhd/skhdrc` for keybindings (uses `.define` command definitions)
- Reload both after changes (see "Reload configurations" above)

**Testing Brewfile changes**:
```bash
brew bundle check    # Verify installed packages
brew bundle cleanup  # Remove packages not in Brewfile (dry-run)
brew bundle dump     # Generate new Brewfile from installed packages
```

**tmux plugin management**:
- Plugins defined in `.tmux.conf` lines 82-87
- Install plugins: `prefix + I`
- Update plugins: `prefix + U`
- Uninstall removed plugins: `prefix + alt + u`
