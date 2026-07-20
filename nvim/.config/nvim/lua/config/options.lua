local opt = vim.opt

-- Numeração: absoluta na linha atual, relativa nas outras
opt.number = true
opt.relativenumber = true

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
opt.signcolumn = "yes"
opt.scrolloff = 8

opt.undofile = true
opt.swapfile = false

opt.splitright = true
opt.splitbelow = true

vim.g.mapleader = " "
