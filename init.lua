vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- disable netrw at the very start of your init.lua (for nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      modes = {
        char = {
          enabled = false
        }
      }
    },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  }
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Disable line wrapping
vim.o.wrap = false

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set({ "n", "x" }, "<leader>p", "\"_dP", { desc = "[p]aste without yanking" })
vim.keymap.set({ "n", "x" }, "<leader>d", "\"_d", { desc = "[d]elete without yanking" })
vim.keymap.set({ "n", "x" }, "<leader>y", "\"+y", { desc = "[y]ank to system clipboard" })

vim.keymap.set("n", "<leader>w", "<cmd>Write<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>Quit<cr>")

vim.keymap.set("n", "gN", "<cmd>Tabnew<cr>")
vim.keymap.set("n", "H", "<cmd>Tabprev<cr>")
vim.keymap.set("n", "L", "<cmd>Tabnext<cr>")

vim.keymap.set("n", "]d", function ()
  require('vscode-neovim').action('editor.action.marker.nextInFiles')
end)

vim.keymap.set("n", "[d", function ()
  require('vscode-neovim').action('editor.action.marker.prevInFiles')
end)


vim.keymap.set("n", "<leader>yp", function()
	local file_name = vim.fn.fnamemodify(vim.fn.expand("%"), ":t")
	local line_number = vim.fn.line(".")
	local file_line = file_name .. ":" .. line_number

	vim.fn.setreg("+", file_line)
	vim.notify("Copied to clipboard: " .. file_line, vim.log.levels.INFO)
end)

-- vim: ts=2 sts=2 sw=2 et
