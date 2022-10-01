--__   __    _    
--\ \ / /_ _| | __
-- \ V / _` | |/ /
--  | | (_| |   < 
--  |_|\__,_|_|\_\
--                
local hl_theme = {
    Normal = { ctermfg = "grey" },
    LineNr = { ctermfg = "lightblue" },
    Comment = { ctermfg = "darkmagenta" },
    Folded = { ctermfg = "darkblue", ctermbg = "black", bold = true, underline = true},
    Function = { ctermfg = "lightblue", bold = true }
}

for group, style in pairs(hl_theme) do
    vim.api.nvim_set_hl(0, group, style)
end
