return {
  "folke/trouble.nvim",
  cmd = { "Trouble" },
  opts = {
    modes = {
      symbols = {
        win = {
          type = "split", -- split window
          relative = "win", -- relative to current window
          position = "right", -- side
          size = 0.3, -- 30% of the window
        },
      },
    },
  },
}
