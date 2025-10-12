# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a LazyVim-based Neovim configuration with customizations for web development (Tailwind, Svelte), C#/Blazor development, and AI-assisted editing. LazyVim is built on lazy.nvim and provides a modular plugin architecture.

## Architecture

**Core Structure**:
- `init.lua` - Entry point that bootstraps lazy.nvim via `require("config.lazy")`
- `lua/config/` - Core configuration overrides (options, keymaps, autocmds)
- `lua/plugins/` - Plugin specifications organized by category

**Plugin Organization**:
- `core.lua` - Essential plugins (nvim-surround, lazygit, auto-save, tmux-navigation)
- `lsp.lua` - LSP configurations for Tailwind (with Blazor Cn() support), Svelte, Emmet
- `csharp.lua` - C# tooling (Roslyn LSP with Razor support via rzls)
- `ai.lua` - AI assistant (Avante with Claude Sonnet 4)
- `ui.lua` - UI customizations (TokyoNight theme with transparency, Snacks explorer)
- `motion.lua` - Navigation (Hop replaces Flash)
- `utilities.lua` - Additional tools (Spectre, Jot, Ranger)
- `mason.lua` - LSP/tool installation via Mason

## Key Customizations

**Auto-Save**: Configured with special exclusions for Claude Code diff buffers (lua/plugins/core.lua:38-61). Excludes buffers with patterns `(proposed)`, `(NEW FILE - proposed)`, `(New)`, and Claude Code-specific buffer variables.

**C# Development**: Roslyn LSP with Razor support requires rzls installed via Mason. Configuration includes custom command line args for Razor integration (lua/plugins/csharp.lua:22-32).

**Tailwind CSS**: Custom classRegex patterns for Blazor's `Cn()` function (lua/plugins/lsp.lua:11-15).

**Svelte**: File watcher workaround via BufWritePost autocmd (lua/plugins/lsp.lua:26-31).

**Custom Keymaps** (lua/config/keymaps.lua):
- `<C-p>` → Find files
- `<C-x>` → Grep
- `<C-e>` → Explorer
- `<C-q>` → Force quit

## Development Commands

**Format Lua code**:
```bash
stylua .
```

**Check formatting**:
```bash
stylua --check .
```

**Neovim commands**:
- `:Lazy` - Plugin manager UI
- `:Lazy sync` - Update plugins
- `:LazyExtras` - Browse LazyVim extras
- `:Mason` - LSP/tool installer UI
- `:LazyGit` - Git UI (also `<leader>gg` or `<leader>L`)

## Working with Plugins

**Adding plugins**: Create/edit files in `lua/plugins/` with plugin specs. Structure follows:
```lua
return {
  {
    "user/repo",
    opts = { ... }, -- merged with defaults
    dependencies = { ... },
    keys = { ... }, -- lazy-load on keybind
    ft = { ... }, -- lazy-load on filetype
  }
}
```

**Overriding LazyVim plugins**: Use same plugin name with `opts` or `enabled = false` (see lua/plugins/ui.lua:3 for bufferline disable, lua/plugins/motion.lua:3 for flash disable).

**Mason Registry**: Custom registry included for rzls (lua/plugins/mason.lua:7).
