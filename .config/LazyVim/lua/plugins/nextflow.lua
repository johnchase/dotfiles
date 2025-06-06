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

    -- Configure Nextflow LSP
    vim.lsp.enable("nextflow")

    vim.lsp.config["nextflow"] = {
      cmd = { "java", "-jar", vim.fn.expand("~/language-server-all.jar") },
      filetypes = { "nextflow", "nf", "groovy", "config" },
      root_markers = { "nextflow.config", ".git" },
      settings = {
        nextflow = {
          files = {
            exclude = { ".git", ".nf-test", "work" },
          },
        },
      },
    }
  end,
}
