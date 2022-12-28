local util = require("ft.util")
local api = vim.api

--Variables for configuration
local python_winopts = {
    foldmethod = "indent",
    foldexpr = ""
}
local python_bufopts = { formatoptions = "cjnqrt" }
local python_keymaps = {
    {
	mode = "n",
	key = "<Leader>f",
	action = "adef (<++>):<CR>\"\"\"<CR>\"\"\"<Esc>2kF(i",
	_opts = { noremap = true }
    },
    {
	mode = "n",
	key = "<C-c>",
	action = function() comment("#") end,
	_opts = { noremap = true }
    },
    {
	mode = "v",
	key = "<C-c>",
	action = function() loop_selection(
		comment,
		"#" 
		) end,
	_opts = { noremap = true }
    },
    {
	mode = "n",
	key = "<F5>",
	action = ":w<CR>:!python3 %<CR>",
	_opts = { noremap = true }
    }
}

--Configuration via autocommands
api.nvim_create_augroup("PYTHON", { clear = true })
api.nvim_create_autocmd(
    "Filetype",
    {
	group = "PYTHON",
	pattern = "python",
	callback = function() util.win_opts(python_winopts) end
    }
)
api.nvim_create_autocmd(
    "Filetype",
    {
	group = "PYTHON",
	pattern = "python",
	callback = function() util.buf_opts(python_bufopts) end
    }
)
api.nvim_create_autocmd(
    "Filetype",
    {
	group = "PYTHON",
	pattern = "python",
	callback = function() keymap_callback(python_keymaps) end
    }
)


