local map = vim.keymap.set

map("n", "<leader>w", ":w<CR>", { desc = "Salvar" })
map("n", "<leader>q", ":q<CR>", { desc = "Sair" })
map("n", "<Esc>", ":nohlsearch<CR>", { desc = "Limpar busca" })
