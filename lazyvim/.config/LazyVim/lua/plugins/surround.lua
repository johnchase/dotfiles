return {
  {
    "nvim-mini/mini.surround",
    opts = {
      -- Add a custom mapping for triple backticks
      mappings = {
        -- Your existing mappings
      },
      -- Add custom surroundings
      custom_surroundings = {
        -- Make `)` insert parts with spaces. `input` pattern stays the same.
        -- ["b"] = { output = { left = "```", right = " ```" } },
        j = {
          output = {
            left = '"""',
            right = '"""',
          },
        },

        c = {
          output = {
            left = "{",
            right = "}",
          },
        },
        d = {
          output = {
            left = "```",
            right = "```",
          },
        },
      },
    },
  },
}
