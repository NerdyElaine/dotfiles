vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.guicursor = ""

-- Options
vim.o.winborder = "bold"
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
vim.o.scrolloff = 10
vim.o.updatetime = 50
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
    { src = 'https://github.com/nvim-telescope/telescope.nvim',              version = "0.1.8" },
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
    { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
    { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
    { src = 'https://github.com/saghen/blink.cmp' },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
    { src = 'https://github.com/xiyaowong/transparent.nvim' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter',            version = "main" },
    { src = 'https://github.com/mason-org/mason.nvim' },
    { src = 'https://github.com/folke/flash.nvim' },
    { src = 'https://github.com/norcalli/nvim-colorizer.lua' },
    { src = 'https://github.com/goolord/alpha-nvim' },
})

require "everforest".setup({
    background = "soft",
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

require("nvim-web-devicons").setup()

require("mini.pairs").setup()

require("mini.surround").setup()

require("snack")

require("orgmode").setup({
    org_agenda_files = '~/orgfiles/**/*',
    org_default_notes_file = '~/orgfiles/inbox.org',
    org_highlight_latex_and_related = 'native',
})

require("org-roam").setup({
    directory = '~/orgfiles/',
})

require('org-bullets').setup()

local actions = require("telescope.actions")

require("telescope").setup({
    mappings = {
        i = {
            ["<Esc>"] = require("telescope.actions").close,
        }
    },
    preview = {
        treesitter = true
    },
    color_devicons = true,
    pickers = {
        find_files = {
            find_command = {
                'rg',
                '--files',
                '--hidden',
                '-g',
                '!.git'
            }
        },
        live_grep = {
            file_ignore_patterns = { 'node_modules', '.git', '.venv' },
            additional_args = function()
                return { "--hidden" }
            end
        },
    }
})
local builtin = require('telescope.builtin')

require("telescope").load_extension("ui-select")
require("telescope").load_extension("orgmode")


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
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["q"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
    },
    float = {
        padding = 4,
    },
})


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
    "lua_ls", "css_ls", "ts_ls", "rust_analyzer", "clangd", "haskell-language-server", "tailwind_css", "pyright",
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
-- Colemak keymap

-- Unmap 'n' and 'N' in normal mode to disable their default search navigation
vim.keymap.set("n", "n", "", { silent = true }) -- Unmap 'n'
vim.keymap.set("n", "N", "", { silent = true }) -- Unmap 'N'
vim.keymap.set("v", "i", "", { silent = true }) -- Unmap 'i' for visual mode
vim.keymap.set("v", "k", "", { silent = true }) -- Unmap 'k' for visual mode
vim.keymap.set("o", "i", "", { silent = true }) -- Unmap 'i' for operator mode

-- Normal mode mappings
vim.keymap.set("n", "k", "nzzzv", { silent = true })
vim.keymap.set("n", "K", "Nzzzv", { silent = true })
vim.keymap.set("n", "u", "i", { silent = true })
vim.keymap.set("n", "m", "h", { silent = true })
vim.keymap.set("n", "n", "gj", { silent = true }) -- Remap 'n' to 'j'
vim.keymap.set("n", "e", "gk", { silent = true })
vim.keymap.set("n", "i", "l", { silent = true })
vim.keymap.set("n", "l", "u", { silent = true })

-- Visual mode mappings
vim.keymap.set("v", "u", "i", { silent = true })
vim.keymap.set("v", "n", "j", { silent = true })
vim.keymap.set("v", "e", "k", { silent = true })
vim.keymap.set("v", "i", "l", { noremap = true, silent = true })
vim.keymap.set("v", "m", "h", { silent = true })

-- Operator-pending mode mappings
vim.keymap.set("o", "u", "i", { silent = true })
vim.keymap.set("o", "n", "j", { silent = true })
vim.keymap.set("o", "e", "k", { silent = true })
vim.keymap.set("o", "i", "l", { silent = true })
vim.keymap.set("o", "m", "h", { silent = true })

-- Convenient keymaps

vim.keymap.set('n', '<leader>.', ':update<CR> :source<CR>')
vim.keymap.set({ "n", "v", "x" }, ";", ":", { desc = "Self explanatory" })
vim.keymap.set({ "n", "v", "x" }, ":", ";", { desc = "Self explanatory" })
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('i', '<C-i>', '<ESC>', { silent = true })
vim.keymap.set('n', '<ESC><ESC>', ':nohlsearch<CR>', { silent = true })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', 'f', 'e', { silent = true })
vim.keymap.set('n', 'ci', 'ci', { silent = true })
vim.keymap.set('n', 'vi', 'vi', { silent = true })
vim.keymap.set('n', 'di', 'di', { silent = true })
vim.keymap.set("n", "<leader>si", function() Snacks.image.hover() end, { desc = "Image Hover" })
vim.keymap.set("n","<leader>gg", function() Snacks.lazygit() end)

--Navigation keymaps
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'G', 'Gzz')
vim.keymap.set({ 'n', 'v', 'x' }, 'zk', '<cmd>lua require("flash").jump()<CR>', { desc = "Self explanatory" })
vim.keymap.set("n", "<leader>rc", pack_clean)
vim.keymap.set("n", "<C-m>", "<cmd>TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-n>", "<cmd>TmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-e>", "<cmd>TmuxNavigateUp<CR>")
vim.keymap.set("n", "<C-i>", "<cmd>TmuxNavigateRight<CR>")
vim.keymap.set("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<CR>")
--File navigation keymaps
vim.keymap.set('n', '<leader>e', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Telescope diagnostics' })
vim.keymap.set('n', '<leader>H', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>F', ':Oil<CR>', { silent = true })
vim.keymap.set('n', '<leader>f', ':lua require("oil").toggle_float()<CR>', { silent = true })

--Zettelkasten scripts
local ext = require("telescope").extensions.orgmode
    vim.keymap.set("n", "<leader>bh", ext.search_headings, { desc = "Org headlines" })
    vim.keymap.set("n", "<leader>bt", ext.search_tags, { desc = "Org tags" })
    vim.keymap.set("n", "<leader>r", ext.refile_heading, { desc = "Org refile" })
    vim.keymap.set("n", "<leader>li", ext.insert_link, { desc = "Org insert link" })

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
