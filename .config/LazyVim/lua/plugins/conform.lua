return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "black",
        "ruff",
        "pyright",
        "prettier",
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        python = { "black", "ruff", "isort" },
        typescript = { "prettier" },
      },
    },
  },
}
