return {
  -- Disable bufferline (tabs)
  { "akinsho/bufferline.nvim", enabled = false },

  -- TokyoNight theme with transparency
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl, c)
        -- Customize HTML/JSX/TSX tag colors
        hl["@tag.svelte"] = { fg = c.red }
        hl["@tag"] = { fg = c.red } -- Custom component tags <MyComponent>
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },

  -- Snacks explorer on the right
  {
    "snacks.nvim",
    opts = {
      explorer = {
        replace_netrw = true,
      },
      picker = {
        sources = {
          explorer = {
            layout = {
              layout = { position = "right" },
            },
          },
        },
      },
    },
  },
  {
    "folke/zen-mode.nvim",
    keys = {
      {
        "<leader>zm",
        function()
          require("zen-mode").toggle()
        end,
      },
    },
    opts = {
      window = {
        width = 0.65,
        height = 0.9,
        options = {
          number = false,
          relativenumber = false,
          signcolumn = "no",
        },
      },
      plugins = {
        tmux = { enabled = true },
      },
    },
  },
}
