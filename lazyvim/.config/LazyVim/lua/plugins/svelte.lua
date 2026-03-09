return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Add Svelte language server
        svelte = {},
        -- Configure TypeScript server to understand SvelteKit paths
        tsserver = {
          init_options = {
            preferences = {
              importModuleSpecifierPreference = "shortest",
            },
          },
        },
      },
    },
  },
}
