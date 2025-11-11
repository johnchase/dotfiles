return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_installation = true,
      ensure_installed = {
        "tsserver",
        "pyright",
        "ruff_lsp",
        "lua_ls",
        "bashls",
      },
    },
  },
}
