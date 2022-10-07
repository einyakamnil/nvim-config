--Function for table printing
function P(table)
    print(vim.inspect(table))
end

--Function for folding
fold_conf = function(opts)
    vim.o.foldmethod = opts.fdm
    vim.o.foldexpr = opts.fde
end

--Callback for keymapping
keymap_callback = function(opts)
    vim.keymap.set(opts.mode, opts.key, opts.action, opts._opts)
end
--Callback for formatoptions
format_conf = function(opts)
    vim.bo.formatoptions = opts.fo
end

--Toggle comment "cm" on current line
function comment(cm)
    line = vim.api.nvim_get_current_line()
    if(string.sub(line, 1, 2) == cm)
    then
	vim.api.nvim_set_current_line(string.sub(line, 3, -1))

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

vim.keymap.set(
    'v', '<C-c>',
    function() loop_selection(
	    comment,
	     "--" 
	) end
)
vim.keymap.set(
    'n', '<C-c>',
    function() comment("--") end
)
