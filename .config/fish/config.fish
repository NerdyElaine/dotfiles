if status is-interactive
# Commands to run in interactive sessions can go here

set fish_greeting ""

# General aliases
alias v='nvim'                  # Neovim shortcut
alias inv='nvim $(fzf -m --preview="bat --color=always {}")' # Find files with fzf with preview with bat and opens with Neovim
alias o='open'                  # macOS open shortcut
alias owd='open ./'             # Open current dir in Finder (macOS)
alias fm='. ranger'             # Ranger shortcut (switches dir when leaving ranger)
alias rf='rifle'                # Rifle, the ranger file opener shortcut
alias fhistory='history | rg'   # Searches history
alias info='info --vi-keys'     # Enables vi keybindigs in info
alias vc='v *.c'                # Opens all C files in cwd
alias vch='v *.h *.c'           # Opens all C and header files in cwd
alias pdb='python3 -m pdb'      # Python debugger shortcut
alias py='python3'              # Python
alias dis3d='/Users/elaine/.cargo/bin/display3d' #Blahaj


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

# yabai shortcuts
alias yrestart='yabai --restart-service'
alias ystop='yabai --stop-service'
alias ystart='yabai --start-service'

#fastfetch alias
alias ff='hyfetch -b fastfetch'

#FZF setup 
fzf --fish | source
alias fzf='fzf --preview="bat --color=always {}"'

starship init fish | source

set -x PATH $HOME/.cargo/bin $PATH

hyfetch

end
