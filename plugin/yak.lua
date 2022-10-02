--__   __    _    
--\ \ / /_ _| | __
-- \ V / _` | |/ /
--  | | (_| |   < 
--  |_|\__,_|_|\_\
--                
--Colorscheme
local lightblue = 135
local hl_theme = {
    Normal = { ctermfg = 248 },
    LineNr = { ctermfg = 69, ctermbg = 53 },
    Comment = { ctermfg = lightblue, italic = true },
    Folded = { ctermfg = lightblue, ctermbg = 53, bold = true, underline = true },
    Identifier = { ctermfg = 177, bold = true },
    Function = { link = "Identifier", bold = true },
    Type = { link = "Identifier", bold = true },
    Special = { link = "Identifier", bold = true },
    Statement = { ctermfg = 154 },
    Search = { ctermfg = 232, ctermbg = 154, bold = true },
    IncSearch = { link = "Search" },
    Pmenu = { ctermfg = 248, ctermbg = 89, italic = true },
    WildMenu = { link = "Pmenu" },
    PmenuSel = { ctermfg = 248, ctermbg = 52, bold = true },
    Title = { ctermfg = lightblue, bold = true }
}

for group, style in pairs(hl_theme) do
    vim.api.nvim_set_hl(0, group, style)
end
