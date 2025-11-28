-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local unmap = vim.keymap.del

-- File and text search
map("n", "<C-p>", "<leader>ff", { desc = "Find Files", remap = true })
map("n", "<C-x>", "<leader>/", { desc = "Grep", remap = true })
map("n", "<C-e>", "<leader>E", { desc = "Explorer", remap = true })
map("n", "/", function()
  Snacks.picker.lines()
end, { desc = "Fuzzy Find in Buffer" })

-- Dashboard
map("n", "<leader>B", function()
  Snacks.dashboard()
end, { desc = "Open dashboard" })

-- Core
map("n", "<C-q>", "<cmd>q!<cr>", { desc = "Grep", remap = true })

-- Lazygit
map("n", "<leader>G", "<leader>gg", { desc = "Lazy Git (cwd)", remap = true })

-- Remove LazyVim's default <C-d>/<C-u> mappings that conflict with neoscroll
unmap("n", "<C-d>")
unmap("n", "<C-u>")

-- Helpers
map("i", "<C-o>", "->", { desc = "Arrow", remap = true })
map("i", "<C-u>", "=>", { desc = "Double arrow", remap = true })
-- map("i", "<C-8>", "(...)", { desc = "Placeholder", remap = true })
map("i", "<C-\\>", "|>", { desc = "Placeholder", remap = true })
