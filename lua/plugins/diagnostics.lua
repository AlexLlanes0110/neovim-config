return {
  {
    "folke/trouble.nvim",
    cmd = "Trouble",

    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    opts = {
      focus = true,
    },

    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<CR>",
        desc = "Diagnósticos del proyecto",
      },

      {
        "<leader>xb",
        "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
        desc = "Diagnósticos del archivo",
      },

      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<CR>",
        desc = "Símbolos del archivo",
      },

      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<CR>",
        desc = "Definiciones y referencias",
      },
    },
  },
}
