local command_center = require("command_center")
local noremap = {noremap = true}
local silent_noremap = {noremap = true, silent = true}

command_center.add({
  {
    desc = "Telescope find files",
    cmd = "<CMD>Telescope find_files<CR>",
    keys = { "n", "<leader>ff", noremap },
  }, 
})
