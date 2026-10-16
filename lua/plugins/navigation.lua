return {
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },

    keys = {
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files({
            hidden = true,
          })
        end,
        desc = "Buscar archivos",
      },

      {
        "<leader>fg",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Buscar texto",
      },

      {
        "<leader>fb",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Buscar buffers",
      },

      {
        "<leader>fh",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "Buscar ayuda",
      },

      {
        "<leader>fr",
        function()
          require("telescope.builtin").oldfiles()
        end,
        desc = "Archivos recientes",
      },
    },

    config = function()
      require("telescope").setup({
        defaults = {
          prompt_prefix = "   ",
          selection_caret = "➜ ",
          path_display = {
            "smart",
          },
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top",
          },
          file_ignore_patterns = {
            ".git/",
            "node_modules/",
          },
        },
      })
    end,
  },

  {
    "stevearc/oil.nvim",
    cmd = "Oil",

    keys = {
      {
        "-",
        "<cmd>Oil<CR>",
        desc = "Explorador de archivos",
      },
    },

    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = false,

      view_options = {
        show_hidden = true,
        natural_order = true,
      },

      float = {
        padding = 2,
        max_width = 100,
        max_height = 30,
        border = "rounded",
      },
    },
  },
}
