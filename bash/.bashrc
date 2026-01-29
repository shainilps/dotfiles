# .bashrc
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

trash() {
    if [ $# -eq 0 ]; then
        echo "Usage: trash <file>"
        return 1
    fi
    local dir="/home/$USER/recycle_bin/$(date +'%d-%m-%Y')"
    mkdir -p "$dir"
    mv "$1" "$dir"
    echo "Moved '$1' to $dir"
}

function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd <"$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

export EDITOR=nvim

export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.zig/zig-0.15.2/bin:$PATH"

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"

export PATH="$HOME/.foundry/bin:$PATH"

# export FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
# export FZF_DEFAULT_OPTS="--ansi"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="$HOME/.local/share/coursier/bin:$PATH"

export PATH="/opt/riscv/xpack-riscv-none-elf-gcc-15.2.0-1/bin:$PATH"

export FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
    export PATH="$FNM_PATH:$PATH"
    eval "$(fnm env --use-on-cd)"
fi

if [ -r "$HOME/.opam/opam-init/init.sh" ]; then
    . "$HOME/.opam/opam-init/init.sh" >/dev/null 2>&1
fi

if [ -f "$HOME/.ghcup/env" ]; then
    . "$HOME/.ghcup/env"
fi

eval "$(starship init bash)"

eval "$(direnv hook bash)"

eval "$(zoxide init bash)"

eval "$(fzf --bash)"

if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

alias v='nvim'
alias p='pnpm'
alias gd='git status -s | fzf --no-sort --reverse --preview "git diff --color=always {+2}" --preview-window=right:60%:wrap'
alias startup='~/cscript/bin/startup'

vf() {
    nvim "$(fzf --ansi --preview-window right:60% --preview "bat --color=always --style=header,grid --line-range :300 {}")"
}

set -o vi

if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
