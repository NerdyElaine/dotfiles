if status is-interactive
# Commands to run in interactive sessions can go here

#vi mode with colemak-dh keys
function fish_user_key_bindings
	fish_default_key_bindings - M insert
	fish_vi_key_bindings

  bind --preset -M default m 'fish_vi_run_count backward-char'
  bind --preset -M default n 'fish_vi_run_count down-or-search' 
  bind --preset -M default e 'fish_vi_run_count up-or-search'
  bind --preset -M default i 'fish_vi_run_count forward-char'

  bind --preset -m insert u repaint-mode
  bind --preset -m insert U beginning-of-line repaint-mode

  bind --preset -M default f 'fish_vi_run_count forward-word-end'
  bind --preset -M default F 'fish_vi_run_count forward-bigword-end'


  bind --preset -M operator m 'fish_vi_run_count backward-char'
  bind --preset -M operator n 'fish_vi_run_count forward-char'
  bind --preset -M operator e 'fish_vi_run_count up-or-search'
  bind --preset -M operator i 'fish_vi_run_count down-or-search'

  bind --preset -M operator f 'fish_vi_run_count forward-word-end'
  bind --preset -M operator F 'fish_vi_run_count forward-bigword-end'

end 

set fish_cursor_default block
set fish_cursor_insert block
set fish_cursor_replace_one block
set fish_cursor_replace block

set fish_cursor_external line

set fish_cursor_visual block

set fish_greeting ""

set -gx ATUIN_NOBIND "true"
atuin init fish | source

bind \ch _atuin_search
bind -M insert \ch _atuin_search

set -x PATH $HOME/.cargo/bin $PATH
set -x PATH $HOME/.local/share/bob/nvim-bin $PATH
set -x PATH $HOME/.local/bin $PATH

# General aliases
alias v='vim'                  # Neovim shortcut
alias vi='nvim'
alias inv='nvim $(fzf -m --preview="bat --color=always {}")' # Find files with fzf with preview with bat and opens with Neovim
alias o='open'                  # macOS open shortcut
alias owd='open ./'             # Open current dir in Finder (macOS)
alias fm='. yazi'             # yazi shortcut (switches dir when leaving yazi)
alias fhistory='history | rg'   # Searches history
alias dis3d='/Users/elaine/.cargo/bin/display3d' #Blahaj

# Kanata
alias kbd='sudo kanata --cfg ~/dotfiles/kanata/colemak-dh-ansi.kbd'

# Git aliases
alias gl='git log --graph --abbrev-commit --decorate --date=relative --all'
alias glo='git log --oneline --graph --abbrev-commit --decorate --date=relative --all'
alias gst='git status --short --find-renames --branch'
alias gstu='git status --short --find-renames --branch --untracked-files'
alias ga='git add'
alias gaa='git add -A'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gd='git diff'

# Eza aliases
alias ls='eza --icons --group-directories-first'
alias la='eza -a --icons --group-directories-first'
alias lsa='eza -a --icons --group-directories-first'
alias ll='eza -lah --icons --group-directories-first'
alias l='eza -lh --icons --group-directories-first'
alias tree='eza -T --icons -D --group-directories-first'
alias treeall='eza --tree --icons --group-directories-first'

# Brew aliases
alias bupd='brew update'
alias bupg='brew upgrade'
alias binfo='brew info'
alias bsync='brew update && brew upgrade'
alias brm='brew rm'
alias bout='brew outdated'
alias binst='brew install'
alias binstc='brew install --cask'
alias bsstop='brew services stop'
alias bsstart='brew services start'
alias bsrestart='brew services restart'
alias bsrch='brew search'

#Cargo aliases
alias cargo = 'RUSTC_WRAPPER=sccache cargo'

#File shortcuts
alias icloud='yazi ~/Library/Mobile\ Documents/com~apple~CloudDocs/'

#fastfetch alias
alias ff='hyfetch -b fastfetch'

#FZF setup 
fzf --fish | source
alias fzf='fzf --preview="bat -f {}"'

function starship_transient_prompt_func
  starship module character
end

starship init fish | source

enable_transience

hyfetch

end
