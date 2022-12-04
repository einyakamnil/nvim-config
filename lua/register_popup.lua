local api = vim.api
--create buffer for content of registers
api.nvim_create_augroup("REG_POPUP", { clear = true })
local popname = "vim registers"
reg_popbuf = api.nvim_create_buf(false, true)
api.nvim_buf_set_name(reg_popbuf, popname)

--functions to show and close specified registers in a popup
local function get_reg(r)
    return vim.fn.getreg(r):gsub("[\n\r]", "\\n")
end

function close_reg_pop()
    print("This gets executed")
    api.nvim_win_close(reg_popwin, false)
    api.nvim_del_autocmd(au_regpop)
end

function show_reg_win()
    show_regs = { "\"", "+", "*", "/", "0", "-" }
    local max_str_len = 0
    
    for r=1,#(show_regs) do
        local rcontent = get_reg(show_regs[r])
        if (not(rcontent == nil))
        then
	    if string.len(rcontent) > max_str_len
	    then
		max_str_len = string.len(rcontent)
	    end
    	    api.nvim_buf_set_lines(
    	        reg_popbuf,
    	        r-1, r,
    	        false,
		{ show_regs[r] .. ": " .. rcontent }
    	    )
        end
    end
    reg_popwin = api.nvim_open_win(
        reg_popbuf,
        false,
        {
	   relative = "cursor",
    	   anchor = "NW",
    	   width = max_str_len + 5,
    	   height = #(show_regs),
	   bufpos = { 0, 0 },
	   style = "minimal"
        }
    )
    api.nvim_win_set_option(reg_popwin, "foldenable", false)
    api.nvim_win_set_option(reg_popwin, "foldmethod", "manual")
    au_regpop = api.nvim_create_autocmd("TextChangedI",  {
	   group = "REG_POPUP",
    	   pattern = "*",
    	   callback = close_reg_pop,
	   once = true
	}
    )
end

--Show registers when trying to paste from one
vim.api.nvim_set_keymap("i", "<C-r>", "<C-o>:lua show_reg_win()<CR><C-r>", { noremap = true })
--vim.api.nvim_set_keymap("n", "\"", "<C-o>:lua show_reg_win()", { noremap = true })
