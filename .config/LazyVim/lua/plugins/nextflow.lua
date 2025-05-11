return {
  "neovim/nvim-lspconfig",
  init = function()
    -- Detect .nf files as Groovy
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = "*.nf",
      callback = function()
        vim.bo.filetype = "groovy"
      end,
    })
  end,
}
