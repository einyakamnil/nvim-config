--Function for folding
fold_config = function(fdm, fde)
	vim.o.foldmethod = fdm
	vim.o.foldexpr = fde
end

