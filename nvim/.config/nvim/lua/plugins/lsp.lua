return {
  {
    "williamboman/mason.nvim",
    config = function() require("mason").setup() end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "pyright", "jdtls", "lua_ls" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      for _, server in ipairs({ "clangd", "pyright", "jdtls", "lua_ls" }) do
        lspconfig[server].setup({})
      end
    end,
  },
}
