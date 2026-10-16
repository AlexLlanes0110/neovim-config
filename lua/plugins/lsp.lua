return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },

    opts = {
      ensure_installed = {
        "lua_ls",
        "pyright",
        "bashls",
        "jsonls",
        "yamlls",
        "html",
        "cssls",
        "ts_ls",
        "dockerls",
        "docker_compose_language_service",
        "marksman",
        "taplo",
        "sqls",
      },

      automatic_enable = true,
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = {
      "BufReadPre",
      "BufNewFile",
    },

    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },

    config = function()
      local capabilities =
        require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },

            diagnostics = {
              globals = {
                "vim",
              },
            },

            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
              },
            },

            telemetry = {
              enable = false,
            },
          },
        },
      })

      vim.diagnostic.config({
        severity_sort = true,
        underline = true,

        virtual_text = {
          spacing = 2,
          source = "if_many",
        },

        float = {
          border = "rounded",
          source = true,
        },

        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚",
            [vim.diagnostic.severity.WARN] = "󰀪",
            [vim.diagnostic.severity.INFO] = "󰋽",
            [vim.diagnostic.severity.HINT] = "󰌶",
          },
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup(
          "ITProLspAttach",
          { clear = true }
        ),

        callback = function(event)
          local map = function(keys, action, description)
            vim.keymap.set(
              "n",
              keys,
              action,
              {
                buffer = event.buf,
                desc = "LSP: " .. description,
              }
            )
          end

          map("gd", vim.lsp.buf.definition, "Ir a definición")
          map("gD", vim.lsp.buf.declaration, "Ir a declaración")
          map("gr", vim.lsp.buf.references, "Ver referencias")
          map("gi", vim.lsp.buf.implementation, "Ir a implementación")
          map("K", vim.lsp.buf.hover, "Información del símbolo")
          map("<leader>rn", vim.lsp.buf.rename, "Renombrar símbolo")
          map("<leader>ca", vim.lsp.buf.code_action, "Acciones de código")

          map(
            "<leader>ld",
            vim.diagnostic.open_float,
            "Diagnóstico de línea"
          )

          map(
            "[d",
            function()
              vim.diagnostic.jump({
                count = -1,
                float = true,
              })
            end,
            "Diagnóstico anterior"
          )

          map(
            "]d",
            function()
              vim.diagnostic.jump({
                count = 1,
                float = true,
              })
            end,
            "Siguiente diagnóstico"
          )
        end,
      })
    end,
  },
}
