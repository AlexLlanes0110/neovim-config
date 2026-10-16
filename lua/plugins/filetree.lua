return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeOpen" },
    keys = {
      { "<C-b>", "<cmd>NvimTreeToggle<CR>", desc = "Explorador lateral" },
    },
    opts = {
      disable_netrw = true,
      hijack_netrw = false,
      view = { width = 34, side = "left" },
      filters = { dotfiles = false },
      update_focused_file = { enable = true },
    },
  },
}
