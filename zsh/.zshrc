# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Zinit plugin manager
# Check to see if zinit is installed, install if not found
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi
# Load zinit
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

# Case insensitive completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# force zsh not to show completion menu, which allows fzf-tab to capture
# the unambiguous prefix
zstyle ':completion:*' menu no

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false

# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'

# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'

# make full use of tmux "popup" feature
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

### Plugins
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

### Snippets
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::colorize
# zinit snippet OMZP::command-not-found
zinit snippet OMZP::sudo

# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# History
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=$HISTSIZE
HISTDUP=erase
# append to history file instead of overwriting it
setopt appendhistory
# share history with other sessions
setopt sharehistory
# put a space in front of a command to not put it in history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

### Options
setopt autocd
unsetopt beep

### Keybindings
# vim mode
bindkey -v
bindkey '^f' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

### The following lines were added by compinstall
zstyle :compinstall filename '/home/kenny/.zshrc'
# End of lines added by compinstall

### Added by Zinit's installer
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust
### End of Zinit's installer chunk

### Aliases
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
# Edit zsh config file
alias zshcfg="$EDITOR ~/.zshrc"
# How many times can you be bothered to type the same full command names?
alias v="nvim"
alias cl="clear"
alias lg="lazygit"
# Check for available updates
alias cu="checkupdates"
# Check after update to see if anything needs to be restarted
alias cs="sudo checkservices"
# Update official package(s)
alias pacup="sudo pacman -Syu --needed"
# Install official package(s)
alias pacin="sudo pacman -S --needed"
# Uninstall official package(s) and any no longer needed dependencies
alias pacun="sudo pacman -Rs"
# Use eza instead of ls
alias ls="eza --icons --color=always --group-directories-first"
alias ll="eza -lF --header --git --git-repos --icons --color=always --group-directories-first"
alias la="eza -alF --header --git --git-repos --icons --color=always --group-directories-first"
# Docker
# alias dcu="docker compose up"
# alias dcd="docker compose down"
alias grep="grep --color=auto"
alias md="mkdir -p"
alias shutdown="sudo shutdown now"
alias reboot="sudo reboot"

### Environment Variables
# interactive session related stuff here
# otherwise use .zshenv

# Zoxide - Ignore directories
export _ZO_EXCLUDE_DIRS="$HOME:$HOME/.private/*"
# Zoxide - Print the matched directory before navigating to it
export _ZO_ECHO=1

### Shell integrations
eval "$(zoxide init --cmd cd zsh)"
eval "$(fzf --zsh)"

### Custom Functions
# create a directory and cd into it
mdcd() {
  mkdir -p "$@" && cd "$@"
}

### Extras
# Command not found handler, requires package "pkgfile"
#source /usr/share/doc/pkgfile/command-not-found.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# pnpm
export PNPM_HOME="/home/kenny/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
