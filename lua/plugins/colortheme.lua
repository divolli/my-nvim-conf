return {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("gruvbox").setup({
			contrast = "hard",
			transparent_mode = true,
			invert_selection = false,
			italic = {
				strings = true,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			bold = true,
		})

		vim.cmd.colorscheme("gruvbox")

		-- Toggle transparency function
		local transparent = false
		local function toggle_transparency()
			transparent = not transparent
			require("gruvbox").setup({
				contrast = "hard",
				transparent_mode = transparent,
				invert_selection = false,
				italic = {
					strings = true,
					emphasis = true,
					comments = true,
					operators = false,
					folds = true,
				},
				bold = true,
			})
			vim.cmd.colorscheme("gruvbox")
		end

		vim.keymap.set("n", "<leader>bg", toggle_transparency, { noremap = true, silent = true })
	end,
}
