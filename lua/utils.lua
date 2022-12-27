--local variables and helper functions
local M = {}
local api = vim.api

local function getline(lnum)
    -- Returns the specified line number of the current buffer
    return tostring(api.nvim_buf_get_lines(0, lnum - 1, lnum, true)[1])
end

local function str_in_line(line, pttrns)
    for _, p in ipairs(pttrns) do
        if(string.find(line, p)) then
            return true
        end
    end

    return false
end

--Easy table printing
function P(table)
    print(vim.inspect(table))
end

--Reload script
function Reload(module)
    package.loaded[module] = nil
    return require(module)
end

--Callback for setting window options
function win_opts(opts)
    for key, val in pairs(opts) do
	vim.wo[key] = val
    end
end

--Callback for buffer options
function buf_opts(opts)
    for key, val in pairs(opts) do
	vim.bo[key] = val
    end
end

--Callback for keymapping
keymap_callback = function(opts)
    for i, map in ipairs(opts) do
	vim.keymap.set(map.mode, map.key, map.action, map._map)
    end
end
--Toggle comment "cm" on current line
function comment(cm)
    line = api.nvim_get_current_line()
    cmlen = string.len(cm)
    if(string.sub(line, 1, cmlen) == cm) then
	api.nvim_set_current_line(string.sub(line, cmlen + 1, -1))

    else
	api.nvim_set_current_line(cm .. line)

    end
end

--Repeat functions of normal mode in visual mode on all selected lines
function loop_selection(func, opts)
    cursor = vim.fn.getpos('.')
    start = cursor[2]
    col = cursor[3]
    fin = vim.fn.line('v')

    if(fin > start) then
	inc = 1
    else
	inc = -1
    end

    for i = start, fin, inc do
	api.nvim_win_set_cursor(0, { i, col })
	func(opts)
    end
    
    api.nvim_win_set_cursor(0, { start, col })
end

--Automatically end latex segments
function tex_begin()
    pos = api.nvim_win_get_cursor(0)
    b = "\\begin{<++>}"
    e = "\\end{<++>}"
    api.nvim_buf_set_lines(0, pos[1], pos[1], false, { b, e })
    pos[1] = pos[1] + 1
    api.nvim_win_set_cursor(0, pos)
    api.nvim_feedkeys("vj:s/<++>/", "n", true)
end
--Custom indenter
function M.lua_indentexpr()
    local pttrn = { "[%(%{%[]$", "function", "^%s*if.*then$", "^%s*else$", "^%s*elseif$", "^%s*for.*do$" }
    local curpos = api.nvim_win_get_cursor(0)
    local prevlnum = vim.fn.prevnonblank(curpos[1] - 1)

    if(prevlnum == 0) then
	return 0
    end

    local ind = vim.fn.indent(prevlnum)
    local prevl = getline(prevlnum)
    local pidx = str_in_line(prevl, pttrn)

    print(pidx)
    if(pidx) then
	return ind + vim.o.shiftwidth
    else
	return 0
    end

    print(pidx)
end

--vim.g.LuaIndenter = M.lua_indentexpr()
--M.lua_indentexpr()

return M
