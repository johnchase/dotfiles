local function getColorScheme()
  local currentTime = os.date("*t")
  local currentHour = currentTime.hour

  local color

  if currentHour >= 6 and currentHour < 11 then
    color = "gruvbox"
  elseif currentHour >= 11 and currentHour < 15 then
    color = "everforest"
  else
    color = "tokyonight"
  end

  return color
end

return {
  { "neanias/everforest-nvim" },
  { "ellisonleao/gruvbox.nvim" },
  { "rebelot/kanagawa.nvim" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "rose-pine/neovim", name = "rose-pine" },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = getColorScheme(),
    },
  },
}
