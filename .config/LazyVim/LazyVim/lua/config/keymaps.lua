-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local wk = require("which-key")
wk.add({
  { "<leader>cj", "<cmd>Neogen<cr>", desc = "Generate docstring" },
})

-- add key map in case <S-CR> doesn't work. Like tmux for example
vim.keymap.set({ "n", "i" }, "<C-w>p", "<S-CR>", { desc = "Pick window (like Shift+Enter)", remap = true })
