-- Create and toggle terminal windows.
return {
  {
    "folke/snacks.nvim",
    opts = {
      terminal = {
        win = {
          position = "float",
          -- border = "single",
          border = "rounded",
        },
      },
    },
  },
}
