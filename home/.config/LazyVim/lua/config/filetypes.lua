-- lua/config/filetypes.lua

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "svelte", "typescript", "javascript", "html", "css" },
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.expandtab = true
  end,
})
