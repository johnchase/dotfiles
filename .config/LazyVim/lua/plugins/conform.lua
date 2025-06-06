return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format", "ruff_fix" },
        -- python = { "isort", "black" }, -- Add isort before black
      },
      formatters = {
        isort = {
          -- Add any isort-specific configuration here
          prepend_args = { "--profile", "black" }, -- Optional: make isort compatible with black
        },
      },
    },
  },
}
