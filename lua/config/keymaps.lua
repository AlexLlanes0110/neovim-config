local map = vim.keymap.set

map("n", "<C-s>", "<cmd>write<CR>", {
  desc = "Guardar archivo",
})

map("i", "<C-s>", "<Esc><cmd>write<CR>a", {
  desc = "Guardar archivo",
})

map("n", "<leader>w", "<cmd>write<CR>", {
  desc = "Guardar archivo",
})

map("n", "<leader>q", "<cmd>quit<CR>", {
  desc = "Cerrar ventana",
})

map("n", "<C-h>", "<C-w>h", { desc = "Ventana izquierda" })
map("n", "<C-j>", "<C-w>j", { desc = "Ventana inferior" })
map("n", "<C-k>", "<C-w>k", { desc = "Ventana superior" })
map("n", "<C-l>", "<C-w>l", { desc = "Ventana derecha" })

map("n", "<Esc>", "<cmd>nohlsearch<CR>", {
  desc = "Limpiar búsqueda",
})

map("n", "<leader>cp", function()
  local path = vim.fn.expand("%:p")

  if path == "" then
    vim.notify(
      "El buffer actual no tiene una ruta",
      vim.log.levels.WARN
    )
    return
  end

  vim.fn.setreg("+", path)
  vim.notify("Ruta copiada: " .. path)
end, {
  desc = "Copiar ruta absoluta",
})

vim.keymap.set("n", "<C-p>", function() require("telescope.builtin").find_files({ hidden = true }) end, { desc = "Buscar archivos" })
