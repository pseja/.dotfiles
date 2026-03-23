# autostart tmux if not already in a tmux session and in an interactive shell (also dodge vscode terminal)
if [[ -z "$TMUX" && -n "$PS1" && "$TERM_PROGRAM" != "vscode" ]]; then
    exec tmux new-session -A -s main
fi

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

# init starship
eval "$(starship init zsh)"

export XDG_CONFIG_HOME=~/.config/

export NVM_DIR="$HOME/.config//nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# run tmux
tmux

