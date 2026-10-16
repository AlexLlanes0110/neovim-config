return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    dependencies = {
      "mason-org/mason.nvim",
    },

    opts = {
      ensure_installed = {
        "stylua",
        "prettier",
        "black",
        "isort",
        "shfmt",
        "sqlfluff",
      },

      auto_update = false,
      run_on_start = true,
      start_delay = 1000,
      debounce_hours = 24,
    },
  },

  {
    "stevearc/conform.nvim",
    event = {
      "BufWritePre",
    },

    cmd = {
      "ConformInfo",
    },

    keys = {
      {
        "<leader>fm",
        function()
          require("conform").format({
            async = true,
            lsp_format = "fallback",
          })
        end,
        desc = "Formatear archivo",
      },
    },

    opts = {
      notify_on_error = true,

      format_on_save = function(buffer)
        local disabled_filetypes = {
          sql = true,
        }

        return {
          timeout_ms = 1500,
          lsp_format = disabled_filetypes[vim.bo[buffer].filetype]
              and "never"
            or "fallback",
        }
      end,

      formatters_by_ft = {
        lua = {
          "stylua",
        },

        python = {
          "isort",
          "black",
        },

        javascript = {
          "prettier",
        },

        javascriptreact = {
          "prettier",
        },

        typescript = {
          "prettier",
        },

        typescriptreact = {
          "prettier",
        },

        html = {
          "prettier",
        },

        css = {
          "prettier",
        },

        json = {
          "prettier",
        },

        jsonc = {
          "prettier",
        },

        yaml = {
          "prettier",
        },

        markdown = {
          "prettier",
        },

        sh = {
          "shfmt",
        },

        bash = {
          "shfmt",
        },

        sql = {
          "sqlfluff",
        },
      },
    },
  },
}
