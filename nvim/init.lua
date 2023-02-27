local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '

if vim.g.vscode then
  require('lazy').setup('plugins.leap')
  require('lazy').setup('plugins.surround')
  require('lazy').setup('base.base')
  require('lazy').setup('base.maps')
  vim.cmd([[source $HOME/.config/nvim/lua/vscode/settings.vim]])
else
  require('lazy').setup('plugins')
  require('base.base')
  require('base.maps')
  require('base.color')
end
