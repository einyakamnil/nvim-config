--			 _
-- _ ___  ___  _____   _(_)_ __ ____  
--| '_  \/ _ \/ _ \ \ / / | '_ ` _  \ 
--| | | |  __/ (_) \ V /| | | | | | |
--|_| |_|\___|\___/ \_/ |_|_| |_| |_|
--                                   
--Load plugins
require('plugins')

--Some nice basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.compatible = false
vim.opt.incsearch = true
vim.opt.encoding = "utf-8"
vim.opt.hlsearch = false
vim.opt.scrolloff = 8
vim.opt.omnifunc = "syntaxcomplete#Complete"
vim.opt.termguicolors = false
vim.opt.undofile = true

--Better indenting
vim.cmd[[filetype indent off]]
vim.opt.tabstop = 8
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = false
vim.opt.cindent = true

--Good general key mappings
vim.api.nvim_set_keymap("n", "<Space>", ":", { noremap = true })
vim.api.nvim_set_keymap("n", "<CR>", "/", { noremap = true })
vim.api.nvim_set_keymap("n", "z", "zA", { noremap = true })

--Jump to tag signs
vim.api.nvim_set_keymap("i", "<C-c>", "<Esc>/<++><CR>\"_c4l", { noremap = true })

--Automatic brackets and quotes
vim.api.nvim_set_keymap("i", "(", "()<++><Esc>4hi", { noremap = true })
vim.api.nvim_set_keymap("i", "[", "[]<++><Esc>4hi", { noremap = true })
vim.api.nvim_set_keymap("i", "{", "{}<++><Esc>4hi", { noremap = true })
vim.api.nvim_set_keymap("i", "'", "''<++><Esc>4hi", { noremap = true })
vim.api.nvim_set_keymap("i", "\"", "\"\"<++><Esc>4hi", { noremap = true })
vim.api.nvim_set_keymap("i", "(<CR>", "(<CR>)<CR><++><Esc>kO", { noremap = true })
vim.api.nvim_set_keymap("i", "[<CR>", "[<CR>]<CR><++><Esc>kO", { noremap = true })
vim.api.nvim_set_keymap("i", "{<CR>", "{<CR>}<CR><++><Esc>kO", { noremap = true })
vim.api.nvim_set_keymap("i", "((", "(", { noremap = true })
vim.api.nvim_set_keymap("i", "[[", "[", { noremap = true })
vim.api.nvim_set_keymap("i", "{{", "{", { noremap = true })
vim.api.nvim_set_keymap("i", "''", "'", { noremap = true })
vim.api.nvim_set_keymap("i", "\"\"", "\"", { noremap = true })


--Faster navigation
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w><C-h>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w><C-j>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w><C-k>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w><C-l>", { noremap = true })
vim.api.nvim_set_keymap("n", "J", "<C-e>", { noremap = true })
vim.api.nvim_set_keymap("n", "K", "<C-y>", { noremap = true })

--Load custom functions
require('custom_funcs')

--Settings for Lua files
vim.api.nvim_create_augroup("LUA", { clear = true })

vim.api.nvim_create_autocmd("Filetype", {
	group = "LUA",
    	pattern = "lua",
	callback = function() fold_config(
	    	"expr",
	    	"(getline(v:lnum)=~?'^--.*$')?0:(getline(v:lnum-1)=~?'^--.*$')||(getline(v:lnum+1)=~?'^--.*$')?1:2"
	    ) end
    }
)
vim.api.nvim_create_autocmd("Filetype", {
	group = "LUA",
	pattern = "lua",
	callback = function() format_config(
		"cjlqr"
	) end
    }
)

--Settings for C files.
vim.api.nvim_create_augroup("C", { clear = true })
vim.api.nvim_create_autocmd("Filetype", {
	group = "C",
	pattern = "c",
	callback = function() fold_config(
		"indent",
		""
	    ) end
    }
)
vim.api.nvim_create_autocmd("Filetype", {
	group = "C",
	pattern = "c",
	callback = function() format_config(
		"cjnqrt"
	    ) end
    }
)

--Settings for Python files.
vim.api.nvim_create_augroup("PYTHON", { clear = true })
vim.api.nvim_create_autocmd("Filetype", {
	group = "PYTHON",
	pattern = "python",
	callback = function() fold_config(
		"indent",
		""
	    ) end
    }
)
vim.api.nvim_create_autocmd("Filetype", {
	group = "PYTHON",
	pattern = "python",
	command = "set formatoptions=cjnqrt"
    }
)
vim.api.nvim_create_autocmd("Filetype", {
	group = "PYTHON",
	pattern = "python",
	callback = function() format_config(
		"cjnqrt"
	    ) end
    }
)

--autocmd FileType c	map <silent> <C-c> :s/^/\/\//<CR>:noh<CR>
--autocmd FileType c	map <silent> <C-u> :s/^\s*\/\///<CR>:noh<CR>
--autocmd FileType c	inoremap ;cb /*<CR><CR>/<CR><++><Esc>2ka<Space>
--autocmd FileType c	nnoremap <buffer> <F5>
--			\ :w<CR>:!clear<CR>:!gcc "%" -o "%:r"<CR>:!./"%:r"<CR>
--"autocmd FileType c inoremap ,main
--"			\ <Esc>:-1r<Space>/home/linkai/Vorlagen/intmain.c<CR>
--"			\2j$Fnla
--
--"<-->
--"Settings for C++ files.
--autocmd FileType cpp setlocal formatoptions=ctnqr
--autocmd FileType cpp map <silent> <C-c> :s/^/\/\//<CR>:noh<CR>
--autocmd FileType cpp map <silent> <C-u> :s/^\s*\/\///<CR>:noh<CR>
--autocmd FileType cpp set cindent
--autocmd FileType cpp inoremap ;cb /*<CR><CR>/<CR><++><Esc>2ka<Space>
--autocmd FileType cpp nnoremap <buffer> <F5>
--			\ :w<CR>:!clear<CR>:!make<CR>
--"<-->
--"fast shebangs
--nnoremap ,sh ggO#!/bin/sh<Esc>:w<CR>:e<CR><C-o>
--nnoremap ,python ggO#!/bin/env<Space>python3<Esc>:w<CR>:e<CR><C-o>
--
--Settings for conf files
vim.api.nvim_create_augroup("CONF", { clear = true })
vim.api.nvim_create_autocmd("Filetype", {
	group = "CONF",
	pattern = "conf",
	callback = function() fold_config(
	"expr",
	"(getline(v:lnum)=~?'^\\#.*$')?0:(getline(v:lnum-1)=~?'^\\#.*$')||(getline(v:lnum+1)=~?'^\\#.*$')?1:2"
	) end
    }
)

vim.api.nvim_create_autocmd("Filetype", {
	group = "CONF",
    	pattern = "conf",
    	command = "set formatoptions=cjnqrt"
    }
)
--autocmd FileType conf map <silent> <C-c> :s/^/\#/<CR>:noh<CR>
--autocmd FileType conf	map <silent> <C-u> :s/^\s*\#//<CR>:noh<CR>
--autocmd FileType conf setlocal foldmethod=expr
--autocmd FileType conf setlocal foldexpr=set foldexpr=(getline(v:lnum)=~?'^\#\ .*$')?0:(getline(v:lnum-1)=~?'^\#\ .*?$')\\|\\|(getline(v:lnum+1)=~?'^\#\ .*?$')?1:2
--
--"<-->
--"Settings for HTML files.
--autocmd FileType html	vmap <silent> <C-c> :s/^/<!--/<CR>:'<,'>s/$/-->/<CR>:noh<CR>
--autocmd FileType html	vmap <silent> <C-u> :s/^\s*<!--//<CR>:'<,'>s/-->$//<CR>:noh<CR>
--autocmd FileType html
--			\ inoremap <expr> <CR> pumvisible() ? "\<C-y>\>\<\/\<C-x>\<C-o>\<Esc>2ba" : "\<C-g>u\<CR>"
--autocmd FileType html	inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
--				\ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
--autocmd FileType html	inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
--				\ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
--autocmd FileType html	inoremap < <<C-x><C-o><C-n>
--
--"<-->
--"Settings for Markdown
vim.api.nvim_create_augroup("MARKDOWN", { clear = true })
vim.api.nvim_create_autocmd("Filetype", {
	group = "MARKDOWN",
	pattern = "markdown",
	callback = function() fold_config(
	"expr",
	"(getline(v:lnum)=~?'^\\# .*$')?0:(getline(v:lnum-1)=~?'^\\# .*$')||(getline(v:lnum+1)=~?'^\\# .*$')?1:2"
	) end
    }
)

vim.api.nvim_create_autocmd("Filetype", {
	group = "MARKDOWN",
    	pattern = "markdown",
    	command = "set formatoptions=cjnqrt"
    }
)
--autocmd FileType markdown nnoremap <F5> :w<CR>:!clear<CR>:!pandoc -f markdown -t pdf "%" -o "%:r.pdf"<CR>
--autocmd FileType markdown nnoremap <buffer> <F6> :!zathura --fork "%:r.pdf"<CR><CR>
--autocmd FileType markdown nnoremap <buffer> <F6> :!zathura --fork "%:r.pdf"<CR><CR>
--autocmd FileType markdown set formatoptions+=r
--autocmd FileType markdown set comments=b:*,b:-,b:+,n:>
--autocmd FileType markdown inoremap ;t <Esc>:r $HOME/Vorlagen/latex/traum.md<CR>ggdd/<++><CR>:noh<CR>"_c4l
--autocmd FileType markdown inoremap ;% <C-r>%<Esc>dF.x
--
--"<-->
--"Settings for Matlab/Octave
--autocmd FileType matlab map <silent> <C-c> :s/^/\%/<CR>:noh<CR>
--autocmd FileType matlab	map <silent> <C-u> :s/^\s*%//<CR>:noh<CR>
--
--"<-->
--"Settings for Python files.
--"Save and execute Python script from inside vim using F5.
--autocmd FileType python
--			\ nnoremap <buffer> <F5> :w<CR>:!clear<CR>:exec '!python3' shellescape(@%, 1)<CR>
--autocmd FileType python map <silent> <C-c> :s/^/\#/<CR>:noh<CR>
--autocmd FileType python	map <silent> <C-u> :s/^\s*\#//<CR>:noh<CR>
--autocmd FileType python	inoremap ;d """<CR>"""<CR><++><Esc>2ka
--autocmd FileType python	inoremap ;> >>><Tab>
--
--
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
--"Settings for Vim files.
--autocmd FileType vim	nnoremap <silent> <C-c> :s/^/\"/<CR>:noh<CR>
--autocmd FileType vim	nnoremap <silent> <C-u> :s/^\s*\"//<CR>:noh<CR>
--autocmd FileType vim	vnoremap <silent> <C-c> :s/^/\"/<CR>:noh<CR>
--autocmd FileType vim	vnoremap <silent> <C-u> :s/^\s*\"//<CR>:noh<CR>
--autocmd FileType vim	inoremap < <><Space><++><Esc>5hi
--autocmd FileType vim	inoremap << <
--autocmd FileType vim	inoremap <> <>
--"General markings. Will not get deleted upon reaching them. Jump with <CR>.
--"Fold the "<--> pattern
--autocmd FileType vim setlocal foldmethod=expr
--autocmd FileType vim setlocal
--			\ foldexpr=(getline(v:lnum)=='\"\<\-\-\>')?0:(getline(v:lnum-1)=='\"\<\-\-\>')\\|\\|(getline(v:lnum+1)=='\"\<\-\-\>')?1:2
--
--"<-->
--"Automatically make closing brackets/quote.
--"Double tap if not wanted
--inoremap { {}<++><Esc>4hi
--inoremap {<CR> {<CR>}<CR><CR><++><Esc>2kO
--inoremap {{ {
--inoremap {} {}
--inoremap ( ()<++><Esc>4hi
--inoremap (<CR> (<CR>)<CR><CR><++><Esc>2kO
--inoremap (( (
--inoremap () ()
--inoremap [ []<++><Esc>4hi
--inoremap [<CR> [<CR>]<CR><CR><++><Esc>2kO
--inoremap [[ [
--inoremap [] []
--inoremap " ""<++><Esc>4hi
--inoremap "" "
--inoremap ' ''<++><Esc>4hi
--inoremap '' '
--
--
--"<-->
--"Make brackets, quotes etc. around selected text.
--"Replaces content in the " register.
--vnoremap () s(<C-r>")<Esc>
--vnoremap [] s[<C-r>"]<Esc>
--vnoremap {} s{<C-r>"}<Esc>
--vnoremap '' s'<C-r>"'<Esc>
--vnoremap "" s"<C-r>""<Esc>
--
--"<-->
--"Jump to <++>. use ";<" to quickly make this tag.
--"inoremap <Space><Space> <Esc>/<++><CR>:noh<CR>"_c4l
--inoremap <C-c> <Esc>/<++><CR>:noh<CR>"_c4l
--inoremap ;< <++><Esc>
--
--"<-->
--"Better key bindings to navigate/resize splitscreens.
--nnoremap <C-j> <C-w>j
--nnoremap <C-k> <C-w>k
--nnoremap <C-h> <C-w>h
--nnoremap <C-l> <C-w>l
--nnoremap + <C-w>+
--nnoremap - <C-w>-
--nnoremap < <C-w><
--nnoremap > <C-w>>
--
--"Faster scrolling
--"nnoremap <C-e> <C-e><C-e>
--"nnoremap <C-y> <C-y><C-y>
--
--"<-->
--"scrolling
--inoremap <C-e> <C-o><C-e>
--inoremap <C-y> <C-o><C-y>
--inoremap <C-j> <C-o><C-e>
--inoremap <C-k> <C-o><C-y>
--nnoremap J <C-e>
--nnoremap K <C-y>
--
--"Save clipboard upon exiting vim.
--autocmd VimLeave * call system("xclip -selection clipboard -i", getreg('+'))
--
--"<-->
--"ctags stuff
--nnoremap ü <C-]>
--nnoremap Ü <C-t>
--
--"<-->
--"Use powerline instead of vim statusline
--python3 from powerline.vim import setup as powerline_setup
--python3 powerline_setup()
--python3 del powerline_setup
