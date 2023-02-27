return {
  'sainnhe/everforest',
  'rmagatti/alternate-toggler',
  'windwp/nvim-autopairs',
  'mg979/vim-visual-multi',
  'gcmt/wildfire.vim',
  'tpope/vim-surround',

  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'saadparwaiz1/cmp_luasnip',

  'jose-elias-alvarez/null-ls.nvim',

  'nvim-treesitter/nvim-treesitter',

  'windwp/nvim-ts-autotag',

  'j-hui/fidget.nvim',
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },
  { 'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async' },

  -- git integration
  "lewis6991/gitsigns.nvim",

  "christoomey/vim-tmux-navigator", -- tmux & split window navigation)
}