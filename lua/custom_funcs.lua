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
    for key, val in pairs(opts)
    do
	vim.wo[key] = val
    end
end

--Callback for buffer options
function buf_opts(opts)
    for key, val in pairs(opts)
    do
	vim.bo[key] = val
    end
end

--Callback for keymapping
keymap_callback = function(opts)
    vim.keymap.set(opts.mode, opts.key, opts.action, opts._opts)
end
--Toggle comment "cm" on current line
function comment(cm)
    line = vim.api.nvim_get_current_line()
    cmlen = string.len(cm)
    if(string.sub(line, 1, cmlen) == cm)
    then
	vim.api.nvim_set_current_line(string.sub(line, cmlen + 1, -1))

    else
	vim.api.nvim_set_current_line(cm .. line)

    end
end

function loop_selection(func, opts)
    cursor = vim.fn.getpos('.')
    start = cursor[2]
    col = cursor[3]
    fin = vim.fn.line('v')

    if(fin > start)
    then
	inc = 1
    else
	inc = -1
    end

    for i = start, fin, inc
    do
	vim.api.nvim_win_set_cursor(0, { i, col })
	func(opts)
    end
    
    vim.api.nvim_win_set_cursor(0, { start, col })
end
