require("rick.plugins-setup")
require("rick.core.options")
require("rick.core.keymaps")
require("rick.plugins.comment")

if vim.g.vscode then
else
	require("rick.core.colorscheme")
	require("rick.plugins.nvim-tree")
	require("rick.plugins.lualine")
	require("rick.plugins.telescope")
	require("rick.plugins.nvim-cmp")
	require("rick.plugins.lsp.mason")
	require("rick.plugins.lsp.lspsaga")
	require("rick.plugins.lsp.lspconfig")
	require("rick.plugins.lsp.null-ls")
	require("rick.plugins.autopairs")
	require("rick.plugins.treesitter")
	require("rick.plugins.gitsigns")
	require("leap").add_default_mappings()
end
-- gcc to comment Commnet
-- ys w to surround a word
-- gr to replace with clipboard  replacewithregister
-- lerder ca to import
