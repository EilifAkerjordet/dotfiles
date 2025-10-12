return {
  {
    "snacks.nvim",
    opts = function(_, opts)
      -- Extend the default dashboard keys with custom config shortcuts
      vim.list_extend(opts.dashboard.preset.keys, {
        { icon = " ", key = "a", desc = "Alacritty Config", action = ":e ~/.config/alacritty/alacritty.toml" },
        { icon = " ", key = "y", desc = "Yabai Config", action = ":e ~/.config/yabai/yabairc" },
        { icon = " ", key = "k", desc = "Skhd Config", action = ":e ~/.config/skhd/skhdrc" },
        { icon = " ", key = "K", desc = "Karabiner Config", action = ":e ~/.config/karabiner/karabiner.json" },

        { icon = " ", key = "t", desc = "Tmux config", action = ":e ~/.tmux.conf" },
        { icon = " ", key = "z", desc = "Zsh Config", action = ":e ~/.zshrc" },
        { icon = " ", key = "b", desc = "Sketchybar Config", action = ":e ~/.config/sketchybar/sketchybarrc" },
      })
    end,
  },
}
