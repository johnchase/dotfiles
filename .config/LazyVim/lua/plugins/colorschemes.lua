local function getColorScheme()
  local currentTime = os.date("*t")
  local currentHour = currentTime.hour

  local color

  if currentHour >= 6 and currentHour < 10 then
    color = "rose-pine-moon"
  elseif currentHour >= 10 and currentHour < 14 then
    color = "kanagawa-wave"
  elseif currentHour >= 14 and currentHour < 18 then
    color = "tokyonight"
  else
    color = "gruvbox"
  end

  return color
end

return {
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
