return {
  -- Surround text objects
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  -- Auto-save
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle",
    event = { "InsertLeave", "TextChanged" },
    opts = {
      -- For claude code nvim
      condition = function(buf)
        -- Exclude claudecode diff buffers by buffer name patterns
        local bufname = vim.api.nvim_buf_get_name(buf)
        if bufname:match("%(proposed%)") or bufname:match("%(NEW FILE %- proposed%)") or bufname:match("%(New%)") then
          return false
        end

        -- Exclude by buffer variables (claudecode sets these)
        if
          vim.b[buf].claudecode_diff_tab_name
          or vim.b[buf].claudecode_diff_new_win
          or vim.b[buf].claudecode_diff_target_win
        then
          return false
        end

        -- Exclude by buffer type (claudecode diff buffers use "acwrite")
        local buftype = vim.fn.getbufvar(buf, "&buftype")
        if buftype == "acwrite" then
          return false
        end

        return true -- Safe to auto-save
      end,
    },
  },

  -- Tmux navigation
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
}
