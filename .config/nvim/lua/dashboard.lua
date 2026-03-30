local alpha = require('alpha')
local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {


	[[  ^  ^  ^   ^☆ ★ ☆ ___I_☆ ★ ☆ ^  ^   ^  ^  ^   ^  ^ ]],
	[[ /|\/|\/|\ /|\ ★☆ /\-_--\ ☆ ★/|\/|\ /|\/|\/|\ /|\/|\ ]],
	[[ /|\/|\/|\ /|\ ★ /  \_-__\☆ ★/|\/|\ /|\/|\/|\ /|\/|\ ]],
	[[ /|\/|\/|\ /|\ 󰻀 |[]| [] | 󰻀 /|\/|\ /|\/|\/|\ /|\/|\ ]],
}

dashboard.section.buttons.val = {
	dashboard.button("t", "󰱽 Find file", ":Telescope find_files <CR>"),
	dashboard.button("k", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("c", " Config", ":Oil ~/dotfiles/.config/nvim<CR>"),
	dashboard.button("s", "󰯂 Browse Scripts", ":Oil ~/dotfiles/scripts/<CR>"),
	dashboard.button("q", "󰅙  Quit", ":q!<CR>"),
}

dashboard.section.footer.val = function()
  return vim.g.startup_time_ms or "[[  ]]"
end

dashboard.section.buttons.opts.hl = "Keyword"
dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
