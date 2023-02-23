return  {
	"folke/todo-comments.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
	  require("todo-comments").setup({
	    colors = {
	      error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
	      warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
	      info = { "DiagnosticInfo", "#04CC80" },
	      hint = { "DiagnosticHint", "#10B981" },
	      default = { "Identifier", "#7C3AED" },
	      test = { "Identifier", "#FF00FF" },
	    },
	    keywords = {
	      TODO = { alt = { "todo" } },
	    },
	  })
	end,
      }