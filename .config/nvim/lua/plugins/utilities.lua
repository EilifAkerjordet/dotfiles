return {
  -- Override vim-dadbod-ui default keymaps (from LazyVim SQL extra)
  {
    "kristijanhusak/vim-dadbod-ui",
    keys = {
      -- Explicitly disable default <leader>D keymap (using custom terminal version instead)
      { "<leader>D", false },
    },
  },

  -- Quick notes
  {
    "letieu/jot.lua",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>fj",
        function()
          require("jot").toggle()
        end,
        desc = "Toggle Jot",
      },
    },
  },

  -- Ranger file manager
  {
    "kelly-lin/ranger.nvim",
    cmd = { "Ranger" },
    keys = {
      {
        "<leader>K",
        function()
          require("ranger-nvim").open(true)
        end,
        desc = "Toggle Ranger",
      },
    },
    config = function()
      require("ranger-nvim").setup({})
    end,
  },
}
