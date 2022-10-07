return require('packer').startup(function(use) 
--Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
	'nvim-lualine/lualine.nvim',
	requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
end)

