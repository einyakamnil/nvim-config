--  __   __    __   
--  \ \ / /_ _| | __
--  \  V / _` | |/ /
--  |  | (_| |   < 
--  |_|\__,_|_|\__\
--                
--Colorscheme
local c = {
    black = 232,
    lightblue = 135,
    orange = 154,
    purple = 53,
    grey = 248,
    green = 95,
    red = 52
}

local hl_theme = {
    Normal = { ctermfg = c.grey },
    LineNr = { ctermfg = c.lightblue, ctermbg = c.purple },
    VertSplit = { link = "LineNr" },
    Comment = { ctermfg = c.lightblue, italic = true },
    Folded = { ctermfg = c.lightblue, ctermbg = c.purple, bold = true, underline = true },
    Identifier = { ctermfg = c.lightblue, bold = true },
    Function = { link = "Identifier", bold = true },
    Type = { link = "Identifier", bold = true },
    Special = { link = "Identifier", bold = true },
    Statement = { ctermfg = c.orange },
    Search = { ctermfg = c.black, ctermbg = c.orange, bold = true },
    IncSearch = { link = "Search" },
    Pmenu = { ctermfg = c.grey, ctermbg = c.purple, italic = true },
    WildMenu = { link = "Pmenu" },
    PmenuSel = { ctermfg = c.grey, ctermbg = c.red, bold = true },
    Title = { ctermfg = c.lightblue, bold = true },
    DiffAdd = { ctermfg = c.lightblue },
    DiffChanged = { ctermfg = c.lightblue },
    DiffDelete = { ctermfg = c.lightblue },
    TabLine = { ctermfg = c.grey, ctermbg = c.purple },
    TabLineSel = { ctermfg = c.orange, ctermbg = c.purple, bold = true },
    TabLineFill = { ctermbg = c.purple }
}

for group, style in pairs(hl_theme) do
    vim.api.nvim_set_hl(0, group, style)
end

--Export lualine colors
return {
  normal = {
    a = {fg = c.lightblue, bg = c.purple, gui = 'bold'},
    b = {fg = c.black, bg = c.green},
    c = {fg = c.grey }
  },
  insert = {
    a = {fg = c.purple, bg = c.lightblue, gui = 'bold'},
    b = {fg = c.black, bg = c.green},
    c = {fg = c.grey }
  },
  visual = {
    a = {fg = c.purple, bg = c.orange, gui = 'bold'},
    b = {fg = c.black, bg = c.green},
    c = {fg = c.grey }
  },
  replace = {
    a = {fg = c.red, bg = c.black, gui = 'bold'},
    b = {fg = c.black, bg = c.green},
    c = {fg = c.grey }
  },
  command = {
    a = {fg = c.purple, bg = c.green, gui = 'bold' },
    b = {fg = c.black, bg = c.green},
    c = {fg = c.grey }
  },
  inactive = {
    a = {fg = c.grey, bg = c.purple, gui = 'bold' },
    b = {fg = c.grey, bg = c.red },
    c = {fg = c.grey }
  }
}
