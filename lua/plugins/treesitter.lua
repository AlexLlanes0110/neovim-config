return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",

    event = {
      "BufReadPost",
      "BufNewFile",
    },

    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "css",
          "dockerfile",
          "git_config",
          "git_rebase",
          "gitattributes",
          "gitcommit",
          "gitignore",
          "html",
          "javascript",
          "json",
          "json5",
          "lua",
          "luadoc",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "sql",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "xml",
          "yaml",
        },

        auto_install = true,

        highlight = {
          enable = true,
        },

        indent = {
          enable = true,
          disable = {
            "python",
            "yaml",
          },
        },
      })
    end,
  },
}
