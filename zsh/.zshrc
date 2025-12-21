eval "$(starship init zsh)"

# i m only using two plugins so managing these two myself
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH=$HOME/bin:/usr/local/bin:$PATH

HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=50000

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# for the nvim alias
# export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

alias v='nvim'
alias run="sh ~/cscript/bin/run.sh"
alias startup="~/cscript/bin/startup"
alias p="pnpm"
alias vf='nvim $(fzf)'

#recycle bin
trash(){
 if [ -z "$1" ]; then
    echo "Usage: trash <file>"
    return 1
  fi
 dir="/home/$USER/recycle_bin/$(date +'%d-%m-%Y')"
 mkdir -p "$dir"
 mv "$1" "$dir"
 echo "Moved '$1' to $dir"
}

export PATH="$HOME/.local/bin:$PATH"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

export EDITOR=nvim

# gid diff with fzf
alias gd="git status -s | fzf --no-sort --reverse --preview 'git diff --color=always {+2}' --preview-window=right:60%:wrap"

export FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'"

#direnv
eval "$(direnv hook zsh)"

eval "$(zoxide init zsh)"

# for zig
export PATH="$PATH:$HOME/.zig/zig-0.15.2/bin"


# for yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# vi mode 
# bindkey -v

autoload -Uz edit-command-line
zle -N edit-command-line

autoload -Uz compinit
compinit

bindkey '^E' edit-command-line
# bindkey '^[[Z' expand-or-complete-prefix
# bindkey -M vicmd "^E" edit-command-line

# export KEYTIMEOUT=1

# fnm
FNM_PATH="/home/codeshaine/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/home/codeshaine/.opam/opam-init/init.zsh' ]] || source '/home/codeshaine/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

[ -f "/home/codeshaine/.ghcup/env" ] && . "/home/codeshaine/.ghcup/env" # ghcup-env