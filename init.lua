--    _   __                _         
--   / | / /__  ____ _   __(_)___ ___ 
--  /  |/ / _ \/ __ \ | / / / __ `__ \
-- / /|  /  __/ /_/ / |/ / / / / / / /
--/_/ |_/\___/\____/|___/_/_/ /_/ /_/ 
--Load plugins and colorscheme
require('plugins')
require('custom_funcs')
local yak = require('yak')
require('lualine').setup {
    options = {
	theme = yak,
	section_separators = { left = " ", right = " " }
    },
    sections = {
	lualine_a = { "mode" },
	lualine_b = { "branch", "diff", "diagnostics" },
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
vim.api.nvim_set_keymap("", "<Space>", ":", { noremap = true })
vim.api.nvim_set_keymap("", "<CR>", "/", { noremap = true })
vim.api.nvim_set_keymap("n", ",", ";", { noremap = true })
vim.api.nvim_set_keymap("n", "z", "zA", { noremap = true })

--Jump to tag signs
vim.api.nvim_set_keymap("i", "<C-c>", "<Esc>/<++><CR>\"_c4l", { noremap = true })

--Automatic brackets and quotes
vim.api.nvim_set_keymap("i", "(", "()<++><Esc>4hi", { noremap = true })
vim.api.nvim_set_keymap("i", "[", "[]<++><Esc>4hi", { noremap = true })
vim.api.nvim_set_keymap("i", "{", "{}<++><Esc>4hi", { noremap = true })
vim.api.nvim_set_keymap("i", "()", "()", { noremap = true })
vim.api.nvim_set_keymap("i", "[]", "[]", { noremap = true })
vim.api.nvim_set_keymap("i", "{}", "{}", { noremap = true })
vim.api.nvim_set_keymap("i", "'", "''<++><Esc>4hi", { noremap = true })
vim.api.nvim_set_keymap("i", "\"", "\"\"<++><Esc>4hi", { noremap = true })
vim.api.nvim_set_keymap("i", "(<CR>", "(<CR>)<++><Esc>O", { noremap = true })
vim.api.nvim_set_keymap("i", "[<CR>", "[<CR>]<++><Esc>O", { noremap = true })
vim.api.nvim_set_keymap("i", "{<CR>", "{<CR>}<++><Esc>O", { noremap = true })
vim.api.nvim_set_keymap("i", "((", "(", { noremap = true })
vim.api.nvim_set_keymap("i", "[[", "[", { noremap = true })
vim.api.nvim_set_keymap("i", "{{", "{", { noremap = true })
vim.api.nvim_set_keymap("i", "''", "'", { noremap = true })
vim.api.nvim_set_keymap("i", "\"\"", "\"", { noremap = true })
vim.api.nvim_set_keymap("v", "<Leader>(", "s(<C-r>\")<Esc>", { noremap = true })
vim.api.nvim_set_keymap("v", "<Leader>[", "s[<C-r>\"]<Esc>", { noremap = true })
vim.api.nvim_set_keymap("v", "<Leader>{", "s{<C-r>\"}<Esc>", { noremap = true })
vim.api.nvim_set_keymap("v", "<Leader><", "s<<C-r>\"><Esc>", { noremap = true })
vim.api.nvim_set_keymap("v", "<Leader>'", "s'<C-r>\"'<Esc>", { noremap = true })
vim.api.nvim_set_keymap("v", "<Leader>\"", "s\"<C-r>\"\"<Esc>", { noremap = true })

--Faster buffer size and view mainpulation
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true })
vim.keymap.set("n", "+", "<C-w>+", { noremap = true })
vim.keymap.set("n", "-", "<C-w>-", { noremap = true })
vim.keymap.set("n", "<", "<C-w><", { noremap = true })
vim.keymap.set("n", ">", "<C-w>>", { noremap = true })
vim.keymap.set("", "J", "<C-e>", { noremap = true })
vim.keymap.set("", "K", "<C-y>", { noremap = true })

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
--autocmd FileType markdown inoremap ;t <Esc>:r $HOME/Vorlagen/latex/traum.md<CR>ggdd/<++><CR>:noh<CR>"_c4l
--autocmd FileType markdown inoremap ;% <C-r>%<Esc>dF.x
--"<-->
--"Settings for sh files.
--autocmd FileType sh	map <silent> <C-c> :s/^/\#/<CR>:noh<CR>
--autocmd FileType sh	map <silent> <C-u> :s/^\s*\#//<CR>:noh<CR>
--autocmd FileType sh	nnoremap <silent> <F5> :w!<CR>:!clear<CR>:!sh %<CR>
--autocmd FileType sh	set formatoptions+=r
--
--"<-->
--"Settings for zsh files.
--autocmd FileType zsh	map <silent> <C-c> :s/^/\#/<CR>:noh<CR>
--autocmd FileType zsh	map <silent> <C-u> :s/^\s*\#//<CR>:noh<CR>
--autocmd FileType zsh	nnoremap <silent> <F5> :w!<CR>:!clear<CR>:!zsh %<CR>
--autocmd FileType zsh	set formatoptions+=r
--
--"<-->
--"Settings for LaTeX files.
--"Compile .tex file using <F5> and open with <F6> in Windows.
--"Uncomment command below it,to use it in Linux.
--"replace "zathura" with your own pdf viewer.
--autocmd FileType plaintex	nnoremap <buffer> <F5> :w<CR>:!pdflatex "%" > /dev/null 2>&1 &<CR><CR>
--autocmd FileType plaintex	nnoremap <buffer> <F6> :!zathura --fork "%:r".pdf<CR><CR>
--
--"Commenting in a .tex file.
--autocmd FileType plaintex map <silent> <C-c> :s/^/\%/<CR>:noh<CR>
--autocmd FileType plaintex map <silent> <C-u> :s/^\s*%//<CR>:noh<CR>
--autocmd FileType plaintex inoremap $ $$<Space><++><Esc>5hi
--autocmd FileType plaintex inoremap $$ $
--autocmd FileType plaintex inoremap ` ``'' <++><Esc>F`a
--autocmd FileType plaintex inoremap ,qq \glqq\grqq{}<Space><++><Esc>F\i<Space>
--autocmd FileType plaintex inoremap ,begin \begin{<CR><BS>\end{<Esc><C-v>$kA
--autocmd FileType plaintex inoremap ,tmplt
--			\ <Esc>:-1r<Space>/home/linkai/Vorlagen/template.tex<CR>
--
--"Auto-continue \item
--autocmd FileType plaintex setlocal formatoptions=ctnqr
--autocmd FileType plaintex setlocal comments+=n:\\item,n:\\usepackage
--
--"<-->
--"Same settings for ft=tex
--autocmd FileType tex nnoremap <buffer> <F5> :w<CR>:!pdflatex "%" > /dev/null 2>&1 &<CR><CR>
--autocmd FileType tex nnoremap <buffer> <F6> :!zathura --fork "%:r".pdf<CR><CR>
--
--"Commenting in a .tex file.
--autocmd FileType tex map <silent> <C-c> :s/^/\%/<CR>:noh<CR>
--autocmd FileType tex map <silent> <C-u> :s/^\s*%//<CR>:noh<CR>
--autocmd FileType tex inoremap $ $$<Space><++><Esc>5hi
--autocmd FileType tex inoremap $$ $
--autocmd FileType tex inoremap ` ``'' <++><Esc>F`a
--autocmd FileType tex inoremap ,qq \glqq\grqq{}<Space><++><Esc>F\i<Space>
--autocmd FileType tex inoremap ,begin \begin{<CR><BS>\end{<Esc><C-v>$kA
--autocmd FileType tex inoremap ,tmplt
--			\ <Esc>:-1r<Space>/home/linkai/Vorlangen/template.tex<CR>
--
--"Auto-continue \item
--autocmd FileType tex setlocal formatoptions=ctnqr
--autocmd FileType tex setlocal comments+=n:\\item,n:\\usepackage
--
--"<-->
--"ctags stuff
--nnoremap ü <C-]>
--nnoremap Ü <C-t>
                                    
