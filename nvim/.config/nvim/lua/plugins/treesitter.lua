return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "c", "python", "java", "lua", "bash", "markdown" },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
