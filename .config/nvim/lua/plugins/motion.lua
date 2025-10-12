return {
  -- Disable flash.nvim (replaced by hop.nvim)
  { "folke/flash.nvim", enabled = false },

  -- Hop for quick navigation
  {
    "smoka7/hop.nvim",
    lazy = false,
    version = "*",
    opts = {
      keys = "etovxqpdygfblzhckisuran",
    },
    keys = {
      {
        "s",
        function()
          require("hop").hint_words()
        end,
        desc = "Hop to word",
        mode = { "n", "x", "o" },
      },
    },
  },

  -- Smooth scrolling
  {
    "karb94/neoscroll.nvim",
    lazy = false,
    config = function()
      require("neoscroll").setup({})
    end,
  },
}
