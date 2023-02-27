return {
	'nvim-treesitter/nvim-treesitter',
	config = function()
		-- configure treesitter
		require("nvim-treesitter.configs").setup({
			-- enable syntax highlighting
			highlight = {
				enable = true,
			},
			--
			-- rainbow = {
			--  enable = true,
			--  extende_mode = true,
			--  max_file_lines = nil,
			--},
			-- enable indentation
			indent = { enable = true },
			-- enable autotagging (w/ nvim-ts-autotag plugin)
			autotag = { enable = true },
			-- ensure these language parsers are installed
			ensure_installed = {
				"json",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"markdown",
				"svelte",
				"graphql",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
			},
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
				config = {
					javascript = {
						__default = "// %s",
						jsx_element = "{/* %s */}",
						jsx_fragment = "{/* %s */}",
						jsx_attribute = "// %s",
						comment = "// %s",
					},
				},
			},
			-- auto install above language parsers
			auto_install = true,
		})
	end
}
