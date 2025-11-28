-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Disable auto-root detection (keeps searches in cwd). Better for monorepos.
vim.g.root_spec = { "cwd", "lsp", { ".git", "lua" } }

-- Auto-reload files when changed externally
vim.opt.autoread = true

-- Disable format on save
vim.g.autoformat = false
vim.o.fileformat = "unix"
vim.o.fileformats = "unix,dos"
