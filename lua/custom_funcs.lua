--Wrapper function for local autocmds
local_buffer = function(inner_func, opts)
    vim.api.nvim_create_autocmd("BufEnter", {
	    buffer = opts.buf,
	    callback = function() inner_func(opts) end
	}
    )
end

--Function for folding
fold_conf = function(opts)
    vim.o.foldmethod = opts.fdm
    vim.o.foldexpr = opts.fde
end

--Callback for keymapping
keymap_callback = function(opts)
    vim.api.nvim_set_keymap(opts.mode, opts.key, opts.action, opts._opts)
end
--Callback for formatoptions
format_conf = function(opts)
    vim.o.formatoptions = opts.fo
end
