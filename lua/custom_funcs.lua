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
