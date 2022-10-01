local hl_theme = {
    Normal = { ctermfg = "grey", ctermbg = "black" },
    LineNr = { ctermfg = "lightblue", ctermbg = "black" },
    Comment = { ctermfg = "darkred", ctermbg = "black" },
    Folded = { ctermfg = "blue", ctermbg = "black", italic = true, bold = true },
    Function = { ctermfg = "blue", bold = true }
}

for group, style in pairs(hl_theme) do
    vim.api.nvim_set_hl(0, group, style)
end
