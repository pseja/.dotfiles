# zinit (zsh plugin manager)
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# zinit plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
# git snippets
zinit snippet OMZP::git
# load completions
autoload -U compinit && compinit
zinit cdreplay -q
# completion styles
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza $realpath'
# keybindings
bindkey '^[[Z' autosuggest-accept # shift tab to accept
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward
# configure command history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# aliases
alias ls='eza'
alias tree='eza --tree'
# set cat=batcat on debian/ubuntu and cat=bat on arch
if (( $+commands[apt-get] )); then
    alias cat='batcat -p'
    alias bat='batcat'
elif (( $+commands[pacman] )); then
    alias cat='bat -p'
fi
alias vim='nvim'

# fzf key bindings and fuzzy completion
source <(fzf --zsh)

# init nvm
source /usr/share/nvm/init-nvm.sh

# init starship
eval "$(starship init zsh)"

