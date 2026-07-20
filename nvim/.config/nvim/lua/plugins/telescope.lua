return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local map = vim.keymap.set
    local builtin = require("telescope.builtin")
    map("n", "<leader>ff", builtin.find_files, { desc = "Buscar arquivos" })
    map("n", "<leader>fg", builtin.live_grep, { desc = "Grep no projeto" })
  end,
}
