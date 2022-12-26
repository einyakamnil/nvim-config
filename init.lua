--    _   __                _         
--   / | / /__  ____ _   __(_)___ ___ 
--  /  |/ / _ \/ __ \ | / / / __ `__ \
-- / /|  /  __/ /_/ / |/ / / / / / / /
--/_/ |_/\___/\____/|___/_/_/ /_/ /_/ 
--Load plugins and colorscheme
require('plugins')
require('utils')
require("register_popup")
local yak = require('yak')
require('lualine').setup {
    options = {
	theme = yak,
	section_separators = { left = " ", right = " " }
    },
    sections = {
	lualine_a = { "mode" },
	lualine_b = { "branch", "diagnostics" },
	lualine_c = { "filename" },
	lualine_x = { "encoding", "filetype" },
	lualine_y = { "progress" },
	lualine_z = { "location" }
    },
    inactive_sections = {
	lualine_a = { "branch" },
	lualine_b = { "diff", "diagnostics" },
	lualine_c = { "filename" },
	lualine_x = { "filetype" },
	lualine_y = { "progress" },
	lualine_z = { "location" }
    }
}

--Some nice basic settings
vim.o.number = true
vim.o.relativenumber = true
vim.o.compatible = false
vim.o.incsearch = true
vim.o.encoding = "utf-8"
vim.o.hlsearch = false
vim.o.scrolloff = 8
vim.o.omnifunc = "syntaxcomplete#Complete"
vim.o.termguicolors = false
vim.o.undofile = true
vim.g.mapleader = ";"

--Better indenting
vim.cmd[[filetype indent off]]
vim.o.tabstop = 8
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.autoindent = false
vim.o.cindent = true

--Good general key mappings
vim.keymap.set("", "<Space>", ":", { noremap = true })
vim.keymap.set("", "<CR>", "/", { noremap = true })
vim.keymap.set("n", ",", ";", { noremap = true })
vim.keymap.set("n", "z", "zA", { noremap = true })

--Advanced key mappings
--Jump to tag signs
vim.keymap.set("i", "<C-c>", "<Esc>/<++><CR>\"_c4l", { noremap = true })

--Automatic brackets and quotes
vim.keymap.set("i", "(", "()<++><Esc>4hi", { noremap = true })
vim.keymap.set("i", "[", "[]<++><Esc>4hi", { noremap = true })
vim.keymap.set("i", "{", "{}<++><Esc>4hi", { noremap = true })
vim.keymap.set("i", "()", "()", { noremap = true })
vim.keymap.set("i", "[]", "[]", { noremap = true })
vim.keymap.set("i", "{}", "{}", { noremap = true })
vim.keymap.set("i", "'", "''<++><Esc>4hi", { noremap = true })
vim.keymap.set("i", "\"", "\"\"<++><Esc>4hi", { noremap = true })
vim.keymap.set("i", "(<CR>", "(<CR>)<++><Esc>O", { noremap = true })
vim.keymap.set("i", "[<CR>", "[<CR>]<++><Esc>O", { noremap = true })
vim.keymap.set("i", "{<CR>", "{<CR>}<++><Esc>O", { noremap = true })
vim.keymap.set("i", "((", "(", { noremap = true })
vim.keymap.set("i", "[[", "[", { noremap = true })
vim.keymap.set("i", "{{", "{", { noremap = true })
vim.keymap.set("i", "''", "'", { noremap = true })
vim.keymap.set("i", "\"\"", "\"", { noremap = true })
vim.keymap.set("v", "<Leader>(", "s(<C-r>\")<Esc>", { noremap = true })
vim.keymap.set("v", "<Leader>[", "s[<C-r>\"]<Esc>", { noremap = true })
vim.keymap.set("v", "<Leader>{", "s{<C-r>\"}<Esc>", { noremap = true })
vim.keymap.set("v", "<Leader><", "s<<C-r>\"><Esc>", { noremap = true })
vim.keymap.set("v", "<Leader>'", "s'<C-r>\"'<Esc>", { noremap = true })
vim.keymap.set("v", "<Leader>\"", "s\"<C-r>\"\"<Esc>", { noremap = true })

--Faster buffer size and view mainpulation
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true })
vim.keymap.set("n", "+", "<C-w>+", { noremap = true })
vim.keymap.set("n", "-", "<C-w>-", { noremap = true })
vim.keymap.set("n", "<", "<C-w><", { noremap = true })
vim.keymap.set("n", ">", "<C-w>>", { noremap = true })
vim.keymap.set("n", "J", "<C-e>", { noremap = true })
vim.keymap.set("n", "K", "<C-y>", { noremap = true })

--Settings for Lua files
vim.api.nvim_create_augroup("LUA", { clear = true })
vim.api.nvim_create_autocmd("Filetype", {
	group = "LUA",
	pattern = "lua",
	callback = function() win_opts({
		    foldmethod = "expr",
		    foldexpr = "(getline(v:lnum)=~?'^--.*$')?0:(getline(v:lnum-1)=~?'^--.*$')||(getline(v:lnum+1)=~?'^--.*$')?1:2"
		}) end
    }
)
vim.api.nvim_create_autocmd("Filetype", {
	group = "LUA",
	pattern = "lua",
	callback = function() buf_opts(
	    { formatoptions = "cjlqr" }
	) end
    }
)
local lua_keymaps = {
    {
	mode = "n",
	key = "<C-c>",
	action = function() comment("--") end,
	_opts = { noremap = true }
    },
    {
	mode = "v",
	key = "<C-c>",
	action = function() loop_selection(
		comment,
		"--" 
		) end,
	_opts = { noremap = true }
    },
    {
	mode = "n",
	key = "<Leader>f",
	action = "ofunction (<++>)<CR><++><CR><BS>end<Esc>2kf(i",
	_opts = { noremap = true }
    },
    {
	mode = "n",
	key = "<F4>",
	action = ":so /home/linkai/.config/nvim/init.lua<CR>",
	_opts = { noremap = true }
    },
    {
	mode = "n",
	key = "<F5>",
	action = ":w<CR>:!lua %<CR>",
	_opts = { noremap = true }
    }
}
vim.api.nvim_create_autocmd("Filetype", {
	group = "LUA",
	pattern = "lua",
	callback = function() keymap_callback(lua_keymaps) end
    }
)

--Settings for C and C++ files.
vim.api.nvim_create_augroup("C", { clear = true })
vim.api.nvim_create_autocmd("Filetype", {
	group = "C",
	pattern = { "c", "cpp" },
	callback = function() win_opts({
		foldmethod = "indent",
		foldexpr = ""
	    }) end
    }
)
vim.api.nvim_create_autocmd("Filetype", {
	group = "C",
	pattern = { "c", "cpp" },
	callback = function() buf_opts(
		{ formatoptions = "cjnqrt" }
	    ) end
    }
)
local c_keymaps = {
    {
	mode = "v",
	key = "<C-c>",
	action = function() loop_selection(
		comment,
		"//" 
		) end,
	_opts = { noremap = true }
    },
    {
	mode = "n",
	key = "<C-c>",
	action = function() comment("//") end,
	_opts = { noremap = true }
    },
    {
	mode = "n",
	key = "<F5>",
	action = ":w<CR>:!gcc % -o %:r<CR>!./%:r<CR>",
	_opts = { noremap = true }
    }
}
vim.api.nvim_create_autocmd("Filetype", {
	group = "C",
	pattern = { "c", "cpp" },
	callback = function() keymap_callback(c_keymaps) end
    }
)

--Settings for Python files.
vim.api.nvim_create_augroup("PYTHON", { clear = true })
vim.api.nvim_create_autocmd("Filetype", {
	group = "PYTHON",
	pattern = "python",
	callback = function() win_opts({
		foldmethod = "indent",
		foldexpr = ""
	    }) end
    }
)
vim.api.nvim_create_autocmd("Filetype", {
	group = "PYTHON",
	pattern = "python",
	callback = function() buf_opts(
		{ formatoptions = "cjnqrt" }
	    ) end
    }
)
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
vim.api.nvim_create_autocmd("Filetype", {
	group = "PYTHON",
	pattern = "python",
	callback = function() keymap_callback(python_keymaps) end
    }
)

--Settings for conf files
vim.api.nvim_create_augroup("CONF", { clear = true })
vim.api.nvim_create_autocmd("Filetype", {
	group = "CONF",
	pattern = "conf",
	callback = function() win_opts({
		foldmethod = "expr",
		foldexpr = "(getline(v:lnum)=~?'^\\#.*$')?0:(getline(v:lnum-1)=~?'^\\#.*$')||(getline(v:lnum+1)=~?'^\\#.*$')?1:2"
	}) end
    }
)

vim.api.nvim_create_autocmd("Filetype", {
	group = "CONF",
    	pattern = "conf",
	callback = function() buf_opts(
		{ formatoptions = "cjnqrt" }
	) end
    }
)

local conf_keymaps = {
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
    }
}
vim.api.nvim_create_autocmd("Filetype", {
	group = "CONF",
    	pattern = "conf",
	callback = function() keymap_callback(conf_keymaps) end
    }
)

--Settings for Markdown
vim.api.nvim_create_augroup("MARKDOWN", { clear = true })
vim.api.nvim_create_autocmd("Filetype", {
	group = "MARKDOWN",
	pattern = "markdown",
	callback = function() win_opts({
		foldmethod = "expr",
		foldexpr = "(getline(v:lnum)=~?'^\\# .*$')?0:(getline(v:lnum-1)=~?'^\\# .*$')||(getline(v:lnum+1)=~?'^\\# .*$')?1:2"
	    }) end
    }
)
vim.api.nvim_create_autocmd("Filetype", {
	group = "MARKDOWN",
    	pattern = "markdown",
	callback = function() buf_opts({
		formatoptions = "cjnqrt",
		comments = "b:+,b:-,b:*"
	}) end
    }
)

local md_keymaps = {
    {
	mode = "n",
	key = "<F5>",
	action = ":w<CR>:!pandoc -f markdown -t pdf % -o %:r.pdf<CR>",
	_opts = { noremap = true }
    },
    {
	mode = "n",
	key = "<F6>",
	action = ":w<CR>:!zathura --fork %:r.pdf<CR>",
	_opts = { noremap = true }
    }
}
vim.api.nvim_create_autocmd("Filetype", {
	group = "MARKDOWN",
	pattern = "markdown",
	callback = function() keymap_callback(md_keymaps) end
    }
)

--Settings for Shell files
vim.api.nvim_create_augroup("SHELL", { clear = true })
local sh_keymaps = {
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
	action = ":w<CR>:!sh %<CR>",
	_opts = { noremap = true }
    }
}
vim.api.nvim_create_autocmd("Filetype", {
	group = "SHELL",
	pattern = { "sh", "bash", "zsh" },
	callback = function() keymap_callback(sh_keymaps) end
    }
)
--Settings for LaTeX files
vim.api.nvim_create_augroup("TEX", { clear = true })
local tex_keymaps = {
    {
	mode = "n",
	key = "<C-c>",
	action = function() comment("%") end,
	_opts = { noremap = true }
    },
    {
	mode = "v",
	key = "<C-c>",
	action = function() loop_selection(
		comment,
		"%" 
		) end,
	_opts = { noremap = true }
    },
    {
	mode = "n",
	key = "<F5>",
	action = ":w<CR>:!pdflatex %<CR>",
	_opts = { noremap = true }
    },
    {
	mode = "n",
	key = "<F6>",
	action = ":w<CR>:!zathura %:r.pdf & disown<CR><CR>",
	_opts = { noremap = true }
    },
    {
	mode = "n",
	key = "<Leader>b",
	action = function() tex_begin() end,
	_opts = { noremap = true }
    }
}
vim.api.nvim_create_autocmd("Filetype", {
	group = "TEX",
	pattern = { "tex", "plaintex" },
	callback = function() keymap_callback(tex_keymaps) end
    }
)

--Testing custom indenter
local function str_in_line(line, pttrns)
    for _, p in ipairs(pttrns) do
        if(string.find(line, p)) then
            return true
        end
    end

    return false
end

local function check_indent()
    pttrns = { "[({[]$", "function", "^%s*if.*then$" }
    local cur_pos = vim.api.nvim_win_get_cursor(0)
    local context = vim.api.nvim_buf_get_lines(
	0,
	cur_pos[1] - 2,
	cur_pos[1],
	true
    )
    _, ind_prev = string.find(context[1], "^%s*")
    _, ind_current = string.find(context[2], "^%s*")
--    if (not(string.find(context[1], "function"))) then
    if(not(str_in_line(context[1], pttrns))) then
	if(ind_prev ~= ind_current) then
	    print(string.match(context[1], "^%s*") .. string.sub(context[2], ind_current+1, -1))
	    vim.api.nvim_set_current_line(string.match(context[1], "^%s*") .. string.sub(context[2], ind_current+1, -1))
	    vim.api.nvim_win_set_cursor(0, { cur_pos[1], cur_pos[2] + ind_prev - ind_current })
    end
    end
end

vim.api.nvim_create_augroup("indenter", { clear = true })
vim.api.nvim_create_autocmd("TextChangedI", {
	group = "indenter",
	callback = function() check_indent() end
    }
)
