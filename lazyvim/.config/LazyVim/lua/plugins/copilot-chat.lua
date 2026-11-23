return {
  "LazyVim/LazyVim",
  opts = {
    -- override the CopilotChat extra plugin directly
    extras = {
      ["as/copilot"] = function()
        local Util = require("lazyvim.util")
        Util.on_load("copilot.lua", function()
          require("copilot.status").data.status = require("copilot.statuses").data.status
        end)
      end,
    },
  },
}
