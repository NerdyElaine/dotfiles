vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.guicursor = ""

-- Options
vim.o.winborder = "single"
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.signcolumn = "yes"
vim.o.swapfile = false
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.termguicolors = true
vim.o.ignorecase = true
vim.o.cursorcolumn = false
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.scrolloff = 8
vim.o.updatetime = 50
vim.opt.conceallevel = 2
vim.opt.concealcursor = 'nc'
vim.opt.clipboard:append("unnamedplus")
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true

--Plugins
vim.pack.add({
    { src = 'https://github.com/neanias/everforest-nvim' },
    { src = 'https://github.com/nvim-lualine/lualine.nvim' },
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/christoomey/vim-tmux-navigator' },
    { src = 'https://github.com/rafamadriz/friendly-snippets' },
    { src = 'https://github.com/L3MON4D3/LuaSnip' },
    { src = 'https://github.com/lervag/vimtex' },
    { src = 'https://github.com/nvim-orgmode/orgmode' },
    { src = 'https://github.com/nvim-orgmode/org-bullets.nvim' },
    { src = 'https://github.com/nvim-orgmode/telescope-orgmode.nvim' },
    { src = 'https://github.com/chipsenkbeil/org-roam.nvim' },
    { src = 'https://github.com/folke/snacks.nvim' },
    { src = 'https://github.com/nvim-mini/mini.nvim' },
    { src = 'https://github.com/windwp/nvim-ts-autotag' },
    { src = 'https://github.com/saghen/blink.cmp' },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/leath-dub/snipe.nvim'},
    { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter',            version = "main" },
    { src = 'https://github.com/mason-org/mason.nvim' },
    { src = 'https://github.com/folke/flash.nvim' },
    { src = 'https://github.com/norcalli/nvim-colorizer.lua' },
    { src = 'https://github.com/goolord/alpha-nvim' },
})

require "everforest".setup({
    background = "soft",
    transparent_background_level = 1,
})

local function pack_clean()
    local active_plugins = {}
    local unused_plugins = {}

    for _, plugin in ipairs(vim.pack.get()) do
        active_plugins[plugin.spec.name] = plugin.active
    end

    for _, plugin in ipairs(vim.pack.get()) do
        if not active_plugins[plugin.spec.name] then
            table.insert(unused_plugins, plugin.spec.name)
        end
    end

    if #unused_plugins == 0 then
        print("No unused plugins.")
        return
    end

    local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
    if choice == 1 then
        vim.pack.del(unused_plugins)
    end
end

vim.cmd("colorscheme everforest")

require "flash".setup()

require("luasnip").config.setup({
    enable_autosnippets = true,
    store_selection_keys = "<Tab>",
})

require("luasnip.loaders.from_vscode").load {
    exclude = { "latex" },
}

require("luasnip.loaders.from_lua").load({ paths = "~/dotfiles/.config/nvim/snippets/" })


require("nvim-treesitter").setup({
    autotag = {
        enabled = true,
    }
})

require "render-markdown".setup({
    completion = {
        lsp = {
            enabled = true,
        }
    }
})

require "colorizer".setup({
    "*",
    css = { rgb_fn = true }
})

require('nvim-ts-autotag').setup({
    opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true
    },
    per_filetype = {
        ["html"] = {
            enable_close = false
        }
    }
})

require("mini.icons").setup()

require("mini.pairs").setup()

require("mini.surround").setup()

require("snack")

require("orgmode").setup({
    org_agenda_files = '~/orgfiles/**/*',
    org_default_notes_file = '~/orgfiles/inbox.org',
    org_highlight_latex_and_related = 'native',
})

require("org-mode")

vim.g.vimtex_view_method = "sioyek"
vim.g.vimtex_callback_progpath = "~/.local/share/bob/nvim-bin/nvim"


require("oil").setup({
    default_file_explorer = true,
    lsp_file_methods = {
        enabled = true,
        timeout_ms = 1000,
        autosave_changes = true,
    },
    columns = {
        "icon",
    },
    view_options = {
        show_hidden = true,
    },
    keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        ["q"] = { "actions.close", mode = "n" },
        ["<C-l>"] = "actions.refresh",
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
    },
    use_default_keymaps = true,
    float = {
        padding = 4,
    },
})

require("snipe").setup()

local group = vim.api.nvim_create_augroup("BlinkCmpLazyLoad", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    group = group,
    once = true,
    callback = function()
        require("blink.cmp").setup({
            appearance = {
                nerd_font_variant = "mono",
                use_nvim_cmp_as_default = true,
            },
            completion = {
                documentation = {
                    auto_show = false
                },
                menu = {
                    auto_show = true,
                },
            },
            keymaps = {
                preset = "default",
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            fuzzy = { implementation = "prefer_rust" },
            signature = {
                enabled = true,
            },
            opts_extend = { "sources.default" },
        })
    end,
})

--LSP
require "mason".setup()

vim.lsp.enable({
    "lua_ls", "css_ls", "ts_ls", "rust_analyzer", "clangd", "haskell-language-server", "tailwind_css", "basedpyright",
    "ltex_plus", "bashls", "svelte", "org"
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'svelte', 'markdown', 'lua', 'rust', 'latex', 'typescript', 'javascript', 'c', 'cpp', 'python', 'haskell' },
    callback = function() vim.treesitter.start() end,
})


require("dashboard")
require("autocmd")
require("statusline")

-- Keymaps
local keymap = vim.keymap.set

-- Colemak keymap
-- Unmap 'n' and 'N' in normal mode to disable their default search navigation
keymap("n", "n", "", { silent = true }) -- Unmap 'n'
keymap("n", "N", "", { silent = true }) -- Unmap 'N'
keymap("v", "i", "", { silent = true }) -- Unmap 'i' for visual mode
keymap("v", "k", "", { silent = true }) -- Unmap 'k' for visual mode
keymap("o", "i", "", { silent = true }) -- Unmap 'i' for operator mode

-- Normal mode mappings
keymap("n", "k", "nzzzv", { silent = true })
keymap("n", "K", "Nzzzv", { silent = true })
keymap("n", "u", "i", { silent = true })
keymap("n", "m", "h", { silent = true })
keymap("n", "n", "gj", { silent = true }) -- Remap 'n' to 'j'
keymap("n", "e", "gk", { silent = true })
keymap("n", "i", "l", { silent = true })
keymap("n", "l", "u", { silent = true })

-- Visual mode mappings
keymap("v", "u", "i", { silent = true })
keymap("v", "n", "j", { silent = true })
keymap("v", "e", "k", { silent = true })
keymap("v", "i", "l", { noremap = true, silent = true })
keymap("v", "m", "h", { silent = true })

-- Operator-pending mode mappings
keymap("o", "u", "i", { silent = true })
keymap("o", "n", "j", { silent = true })
keymap("o", "e", "k", { silent = true })
keymap("o", "i", "l", { silent = true })
keymap("o", "m", "h", { silent = true })

-- Convenient keymaps
keymap('n', '<leader>.', ':update<CR> :source<CR>')
keymap({ "n", "v", "x" }, ";", ":", { desc = "Self explanatory" })
keymap({ "n", "v", "x" }, ":", ";", { desc = "Self explanatory" })
keymap('n', '<leader>w', ':write<CR>')
keymap('n', '<leader>q', ':quit<CR>')
keymap('i', '<C-i>', '<ESC>', { silent = true })
keymap('n', '<leader>lf', vim.lsp.buf.format)
keymap('n', 'f', 'e', { silent = true })
keymap('n', 'ci', 'ci', { silent = true })
keymap('n', 'vi', 'vi', { silent = true })
keymap('n', 'di', 'di', { silent = true })
keymap("x", "N", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move visual block down" })
keymap("x", "E", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move visual block up" })
keymap("x", ">", ">gv", { silent = true, desc = "Increase indent of visual block" })
keymap("x", "<", "<gv", { silent = true, desc = "Decrease indent of visual block" })
keymap("n", "<leader>si", function() Snacks.image.hover() end, { desc = "Image Hover" })
keymap("n", "<leader>lg", function() Snacks.lazygit() end)
keymap("n", "<leader>bd", ":Bdelete<cr>", { silent = true, desc = "Close current buffer" })
keymap("n", "<bs>", "<C-^>", { silent = true, desc = "Switch to previous buffer" })

--File navigation keymaps
keymap('n', '<leader>e', function() Snacks.picker.files() end)
keymap('n', '<leader>E', function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end)
keymap('n', '<leader>dg', function() Snacks.picker.git_files() end)
keymap('n', '<leader>g', function() Snacks.picker.grep() end)
keymap('n', '<leader>sd', function() Snacks.picker.diagnostics() end)
keymap('n', '<leader>H', function() Snacks.picker.help() end)
keymap('n', '<leader>F', ':Oil<CR>', { silent = true })
keymap('n', '<leader>f', ':lua require("oil").toggle_float()<CR>', { silent = true })

--Zettelkasten scripts
local tom = require("telescope-orgmode")
tom.setup({ adapter = "snacks" })

vim.keymap.set("n", "<leader>bh", tom.search_headings, { desc = "Org headlines" })
vim.keymap.set("n", "<leader>bt", tom.search_tags, { desc = "Org tags" })
vim.keymap.set("n", "<leader>r", tom.refile_heading, { desc = "Org refile" })
vim.keymap.set("n", "<leader>li", tom.insert_link, { desc = "Org insert link" })

--Navigation keymaps
keymap('n', '<C-d>', '<C-d>zz')
keymap('n', '<C-u>', '<C-u>zz')
keymap('n', 'G', 'Gzz')
keymap({ 'n', 'v', 'x' }, 'zk', '<cmd>lua require("flash").jump()<CR>', { desc = "Self explanatory" })
keymap("n", "<leader>sc", pack_clean)
vim.g.tmux_navigator_no_mappings = 1
keymap('n', '<C-m>', ':TmuxNavigateLeft<cr>', { silent = true })
keymap('n', '<C-n>', ':TmuxNavigateDown<cr>', { silent = true })
keymap('n', '<C-e>', ':TmuxNavigateUp<cr>', { silent = true })
keymap('n', '<C-i>', ':TmuxNavigateRight<cr>', { silent = true })
keymap('n', "gb", require("snipe").open_buffer_menu)

vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "*.jsx,*.tsx",
    group = vim.api.nvim_create_augroup("TS", { clear = true }),
    callback = function()
        vim.cmd([[set filetype=typescriptreact]])
    end
})


vim.api.nvim_create_autocmd("FileType", {
    pattern = { "tex", "bib", "latex", "plaintex" },
    callback = function()
        vim.b.snacks_main_ignore = true
        -- Keymaps for expanding and jumping in snippets
        vim.cmd [[
            imap <silent><expr> kh luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : 'kh'
            smap <silent><expr> kh luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : 'kh'

            imap <silent><expr> wq luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : 'wq'
            smap <silent><expr> wq  luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : 'wq'

            " Cycle forward through choice nodes

            imap <silent><expr> <C-k> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-k>'
            smap <silent><expr> <C-k> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-k>'
            imap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-prev-choice' : '<C-l>'
            smap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-prev-choice' : '<C-l>'
        ]]
    end
})

-- To disable snacks images for tex files because I just use
vim.schedule(function()
    local image_doc = require("snacks.image.doc")
    local original_attach = image_doc.attach
    image_doc.attach = function(buf)
        local ignore_ft = { "tex", "latex", "plaintex" }
        if vim.tbl_contains(ignore_ft, vim.bo[buf].filetype) then
            return
        end
        original_attach(buf)
    end
end)
