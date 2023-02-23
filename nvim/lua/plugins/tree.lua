return {
	'nvim-tree/nvim-tree.lua',
	dependencies = {
		'nvim-tree/nvim-web-devicons', -- optional, for file icons
	},
	version = 'nightly', -- optional, updated every week. (see issue #1193)
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		require("nvim-tree").setup({
			sort_by = "case_sensitive",
			actions = {
				open_file = { quit_on_open = true }
			},
			update_focused_file = {
				enable = true,
				update_cwd = true
			},
			filters = {
				custom = { '^.git$', '^node_modules$' }
			},
			git = {
				enable = false
			},
			log = {
				enable = true,
				types = {
					diagnostics = true
				}
			},
			diagnostics = {
				enable = true,
				show_on_dirs = false,
				debounce_delay = 50,
				icons = {
					hint = '',
					info = '',
					warning = '',
					error = ''
				}
			}
		})

		vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')
	end
}
