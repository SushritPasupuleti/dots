require("toggleterm").setup{}

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal  = require('toggleterm.terminal').Terminal

-- For czg the commit tool
local czg = Terminal:new({ cmd = "czg", hidden = true, direction="float" })

-- General purpose floating terminal
local floating_term = Terminal:new({hidden=true, direction="float", size=60})

-------------Toggle Functions-------------
function _czg_toggle()
  czg:toggle()
end

function _floating_term_toggle()
	floating_term:toggle()
end
------------------------------------------

-------------Key Mappings-----------------
vim.api.nvim_set_keymap("n", "<leader>gz", "<cmd>lua _czg_toggle()<CR>", {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "<leader>ft", "<cmd>lua _floating_term_toggle()<CR>", {noremap = true, silent = true})

