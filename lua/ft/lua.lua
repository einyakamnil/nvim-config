local util = require("ft.util")
local api = vim.api

--Variables for configuration
local lua_indent = { "[%(%{%[]$", "%s*function .*%s[^e][^n][^d]", "^%s*if.*then$", "^%s*else$", "^%s*elseif$", "^%s*for.*do$" }
local lua_redent = { "^%s*[%)%}%]]$", "^%s*end$", "^%s*else$", "^%s*elseif$", "^%s*[%)%}%]]%p$" }
local lua_indkeys = ",0end"
local lua_winopts = {
    foldmethod = "expr",
    foldexpr = "(getline(v:lnum)=~?'^--.*$')?0:(getline(v:lnum-1)=~?'^--.*$')||(getline(v:lnum+1)=~?'^--.*$')?1:2"
}
local lua_bufopts = { formatoptions = "cjlqr" }
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
	action = function() loop_selection(comment, "--") end,
	_opts = { noremap = true }
    },
    {
	mode = "n",
	key = "<Leader>f",
	action = "ofunction (<++>)<CR><++><CR>end<Esc>2kf(i",
	_opts = { noremap = true }
    },
    {
	mode = "n",
	key = "<F5>",
	action = ":w<CR>:!lua %<CR>",
	_opts = { noremap = true }
    }
}
vim.g.LuaIndent = function() return util.yndentexpr(lua_indent, lua_redent) end

--Configuration via autocommands
api.nvim_create_augroup("LUA", { clear = true })
api.nvim_create_autocmd(
    "Filetype",
    {
	group = "LUA",
	pattern = "lua",
	callback = function() util.win_opts(lua_winopts) end
    }
)
api.nvim_create_autocmd("Filetype", {
	group = "LUA",
	pattern = "lua",
	callback = function() util.buf_opts(lua_bufopts) end
    }
)
api.nvim_create_autocmd(
    "Filetype",
    {
        group = "LUA",
	pattern = "lua",
	callback = function() keymap_callback(lua_keymaps) end
    }
)
api.nvim_create_autocmd(
    "Filetype",
    {
        group = "LUA",
	pattern = "lua",
	callback = function() api.nvim_buf_set_option(0, "indentexpr", "LuaIndent()") end
    }
)
api.nvim_create_autocmd(
    "Filetype",
    {
        group = "LUA",
	pattern = "lua",
	callback = function() vim.bo.indentkeys = vim.bo.indentkeys .. lua_indkeys end,
	once = true
    }
)

