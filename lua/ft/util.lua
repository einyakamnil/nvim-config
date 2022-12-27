--local helper functions 
local M = {}
local api = vim.api

local function getline(lnum)
    -- Returns the specified line number of the current buffer
    return tostring(api.nvim_buf_get_lines(0, lnum - 1, lnum, true)[1])
end

local function str_in_line(line, pttrns)
    for _, p in ipairs(pttrns) do
	local strpos, _ = string.find(line, p)
        if(strpos) then
            return true, strpos
        end
    end

    return false, nil
end

--Callback for setting window options
function M.win_opts(opts)
    for key, val in pairs(opts) do
	vim.wo[key] = val
    end
end

--Callback for buffer options
function M.buf_opts(opts)
    for key, val in pairs(opts) do
	vim.bo[key] = val
    end
end

--Callback for keymapping
function M.keymap_callback(opts)
    for _, map in ipairs(opts) do
	vim.keymap.set(map.mode, map.key, map.action, map._map)
    end
end

--Toggle comment "cm" on current line
function M.comment(cm)
    line = api.nvim_get_current_line()
    cmlen = string.len(cm)

    if(string.sub(line, 1, cmlen) == cm) then
	api.nvim_set_current_line(string.sub(line, cmlen + 1, -1))
    else
	api.nvim_set_current_line(cm .. line)
    end
end

--Repeat functions of normal mode in visual mode on all selected lines
function M.loop_selection(func, opts)
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


--Custom indenter
--[[
Takes two arrays of strings patterns.
The first argument contains patterns, which are checked against the contents of the previous line and indents the current line if the pattern is found.
The second argument contains patterns, which reindent the line if the pattern matches.
Requires indentkeys for reindenting.
--]]
function M.yndentexpr(indent, redent)
    local curpos = api.nvim_win_get_cursor(0)
    local prevlnum = vim.fn.prevnonblank(curpos[1] - 1)

    if(prevlnum == 0) then
	return 0
    end

    local prevind = vim.fn.indent(prevlnum)
    local prevl = getline(prevlnum)
    local pidx, ppos = str_in_line(prevl, indent)
    local ind = prevind

    if(pidx and (vim.fn.synIDattr(vim.fn.synID(prevl, ppos, 1), "name") ~= "luaString")) then
	ind = prevind + vim.o.shiftwidth
    else
	ind = prevind
    end

    local ridx, _ = str_in_line(api.nvim_get_current_line(), redent)

    if(ridx) then
	ind = prevind - vim.o.shiftwidth
    end

    return ind
end

return M

