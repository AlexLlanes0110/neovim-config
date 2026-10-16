local group = vim.api.nvim_create_augroup(
  "ITProGeneral",
  { clear = true }
)

vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  pattern = "*",
  callback = function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    pcall(vim.api.nvim_win_set_cursor, 0, cursor)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "yaml", "yaml.docker-compose" },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.expandtab = true
    vim.opt_local.wrap = false
  end,
})

vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  {
    group = group,
    pattern = { ".env", ".env.*" },
    callback = function()
      vim.bo.filetype = "sh"
    end,
  }
)

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.hl.on_yank({
      higroup = "IncSearch",
      timeout = 150,
    })
  end,
})
