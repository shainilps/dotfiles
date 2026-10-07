# .bashrc
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# ---- env ----
export EDITOR=nvim
export BROWSER=brave-browser

export GOROOT=/usr/local/go
export GOPATH="$HOME/go"
export JAVA_HOME="$HOME/.local/jdks/jdk-21.0.12.1+1"
export PNPM_HOME="$HOME/.local/share/pnpm"

export FZF_DEFAULT_OPTS="--ansi --walker-skip=.git,node_modules,.jj"
# file preview only where the items are files (ctrl-t, vf)
export FZF_CTRL_T_OPTS="--preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'"

# ---- path ----
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.zig/zig-x86_64-linux-0.16.0/bin:$PATH"
export PATH="$GOROOT/bin:$GOPATH/bin:$PATH"
export PATH="$HOME/.foundry/bin:$PATH"
export PATH="$HOME/.local/share/coursier/bin:$PATH"
export PATH="/opt/riscv/xpack-riscv-none-elf-gcc-15.2.0-1/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.dpm/bin:$PATH" # remove this once usecase done
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$PNPM_HOME:$PATH"
export PATH="/usr/local/cuda/bin:$PATH"

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# ---- interactive ----
if [ -n "$KITTY_INSTALLATION_DIR" ]; then
    export KITTY_SHELL_INTEGRATION="enabled"
    . "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"
fi

trash() {
    if [ $# -eq 0 ]; then
        echo "Usage: trash <file>"
        return 1
    fi
    local dir="$HOME/recycle_bin/$(date +'%d-%m-%Y')"
    mkdir -p "$dir"
    mv "$1" "$dir"
    echo "Moved '$1' to $dir"
}

y() {
    local tmp cwd
    tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd <"$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

export FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
    export PATH="$FNM_PATH:$PATH"
    eval "$(fnm env)"
fi

if [ -r "$HOME/.opam/opam-init/init.sh" ]; then
    . "$HOME/.opam/opam-init/init.sh" >/dev/null 2>&1
fi

if [ -f "$HOME/.ghcup/env" ]; then
    . "$HOME/.ghcup/env"
fi

eval "$(fzf --bash)"
eval "$(starship init bash)"
eval "$(direnv hook bash)"

alias v='nvim'
alias p='pnpm'
vf() { local f; f=$(FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" fzf) && nvim "$f"; }
alias gd='git status -s | fzf --no-sort --reverse --preview "git diff --color=always {+2}" --preview-window=right:60%:wrap'
alias rss='newsboat'

# set -o vi
