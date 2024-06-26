local function getColorScheme()
  local currentTime = os.date("*t")
  local currentHour = currentTime.hour

  local color

  if currentHour >= 6 and currentHour < 11 then
    color = "catppuccin"
  elseif currentHour >= 11 and currentHour < 15 then
    color = "kanagawa-wave"
  else
    color = "tokyonight"
  end

  return color
end

return {
  { "ellisonleao/gruvbox.nvim" },
  { "rebelot/kanagawa.nvim" },
  { "catppuccin/catppuccin.nvim" },
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
