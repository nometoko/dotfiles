-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.style")

vim.api.nvim_set_keymap("i", "<Tab>", 'pumvisible() ? "<C-y>" : "<Tab>"', { expr = true, noremap = true })
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0

vim.opt.formatoptions:remove("t")
vim.opt.formatoptions:remove("c")
vim.opt.formatoptions:remove("r")

vim.g.python3_host_prog = "/opt/local/bin/python"
