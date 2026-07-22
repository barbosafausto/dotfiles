return {
  {
    "williamboman/mason.nvim",
    config = function() require("mason").setup() end,
  },
  { "neovim/nvim-lspconfig" },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "pyright", "jdtls", "lua_ls" },
      })
    end,
  },
}
