return {
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
    },
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  {
    "lewis6991/gitsigns.nvim",
    event = {
      "BufReadPre",
      "BufNewFile",
    },

    opts = {
      signs = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },

      current_line_blame = false,
    },

    keys = {
      {
        "]c",
        function()
          require("gitsigns").nav_hunk("next")
        end,
        desc = "Siguiente cambio Git",
      },

      {
        "[c",
        function()
          require("gitsigns").nav_hunk("prev")
        end,
        desc = "Cambio Git anterior",
      },

      {
        "<leader>gp",
        function()
          require("gitsigns").preview_hunk()
        end,
        desc = "Previsualizar cambio Git",
      },

      {
        "<leader>gb",
        function()
          require("gitsigns").blame_line({
            full = true,
          })
        end,
        desc = "Git blame de línea",
      },
    },
  },
}
