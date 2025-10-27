if status is-interactive 

    function trash
        if test (count $argv) -eq 0
            echo "Usage: trash <file>"
            return 1
        end
        set dir "/home/$USER/recycle_bin/(date +'%d-%m-%Y')"
        mkdir -p $dir
        mv $argv[1] $dir
        echo "Moved '$argv[1]' to $dir"
    end

    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

    starship init fish | source

    direnv hook fish | source

    zoxide init fish | source

end


# PATH setup
set -x PATH $HOME/bin /usr/local/bin $PATH

set -x PATH $HOME/.local/bin $PATH

set -x PATH /opt/nvim-linux-x86_64/bin $PATH

set -x PATH $HOME/.zig/zig-0.15.2/bin $PATH

# Go
set -x GOROOT /usr/local/go
set -x GOPATH $HOME/go
set -x PATH $GOPATH/bin $GOROOT/bin $PATH

# Editor
set -x EDITOR nvim

# Aliases
abbr -a v nvim

alias startup='~/cscript/bin/startup'
abbr -a p pnpm
abbr -a vf 'nvim (fzf)'

alias gd='git status -s | fzf --no-sort --reverse --preview "git diff --color=always {+2}" --preview-window=right:60%:wrap'

# FZF defaults
set -x FZF_DEFAULT_OPTS "--ansi --preview-window 'right:60%' --preview 'batcat --color=always --style=header,grid --line-range :300 {}'"

# fish_vi_key_bindings
