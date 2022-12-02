local api = vim.api
--create buffer for content of registers
local popname = "vim registers"
reg_popbuf = api.nvim_create_buf(false, true)
api.nvim_buf_set_name(reg_popbuf, popname)

--functions to show specified registers in a popup
local function get_reg(r)
    return vim.fn.getreg(r):gsub("[\n\r]", " ")
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
end
