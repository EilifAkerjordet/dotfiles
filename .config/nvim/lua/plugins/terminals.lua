return {
  -- Floating terminal via Snacks
  {
    "snacks.nvim",
    keys = {
      {
        "<C-t>",
        function()
          Snacks.terminal.toggle(nil, {
            env = { SNACKS_TERMINAL_ID = "term" },
            win = { position = "float", height = 0.99, width = 0.99, border = "rounded" },
          })
        end,
        desc = "Toggle Terminal",
        mode = { "n", "t" },
      },
      {
        "<leader>V",
        function()
          Snacks.terminal.toggle(nil, {
            env = { SNACKS_TERMINAL_ID = "server" },
            win = { position = "float", height = 0.99, width = 0.99, border = "rounded" },
          })
        end,
        desc = "Toggle servers",
        mode = { "n", "t" },
      },
      {
        "<leader>C",
        function()
          Snacks.terminal.toggle("lazydocker", {
            env = { SNACKS_TERMINAL_ID = "lazydocker" },
            win = { position = "float", height = 0.99, width = 0.99, border = "rounded" },
          })
        end,
        desc = "Toggle Lazydocker",
        mode = { "n", "t" },
        remap = true,
      },
      {
        "<leader>P",
        function()
          Snacks.terminal.toggle("posting", {
            env = { SNACKS_TERMINAL_ID = "posting" },
            win = { position = "float", height = 0.99, width = 0.99, border = "rounded" },
          })
        end,
        desc = "Toggle posting",
        mode = { "n", "t" },
        remap = true,
      },
      {
        "<leader>D",
        function()
          Snacks.terminal.toggle({
            "nvim",
            "-c",
            -- To turn off disturbing UI elements making it feel more like a "native" TUI app (not running in nvim)
            "autocmd VimEnter * lua vim.defer_fn(function() vim.opt.laststatus = 0 vim.opt.cmdheight = 0 vim.opt.showtabline = 0 vim.opt.number = false vim.opt.relativenumber = false vim.opt.signcolumn = 'no' vim.opt.foldcolumn = '0' vim.opt.fillchars = { eob = ' ' } end, 0)",
            "-c",
            "DBUI",
          }, {
            env = { SNACKS_TERMINAL_ID = "dadbod" },
            win = { position = "float", height = 0.99, width = 0.99, border = "rounded" },
          })
        end,
        desc = "Toggle DB UI",
        mode = { "n", "t" },
        remap = true,
      },
    },
  },
}
