return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_installation = true,
      ensure_installed = {
        "ts_ls",
        "pyright",
        "lua_ls",
        "bashls",
      },
    },
  },
}
