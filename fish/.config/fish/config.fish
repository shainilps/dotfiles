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

    set -x FNM_PATH "$HOME/.local/share/fnm"


    if test -d "$FNM_PATH"
    set -x PATH "$FNM_PATH" $PATH
        fnm env | source
    end

    # Initialize opam if available
    if test -r "$HOME/.opam/opam-init/init.fish"
        source "$HOME/.opam/opam-init/init.fish"
    end

    #ghc
    if test -f /home/codeshaine/.ghcup/env.fish
        source /home/codeshaine/.ghcup/env.fish
    end

    starship init fish | source

    direnv hook fish | source

    zoxide init fish | source

end

#it was delegating the command to the bash which caused delay so overriding that behaviour by adding default  
function fish_command_not_found
    __fish_default_command_not_found_handler $argv
end

set -U fish_greeting 

# PATH setup
set -x PATH $HOME/bin /usr/local/bin $PATH

set -x PATH $HOME/.local/bin $PATH

set -x PATH $HOME/.zig/zig-0.15.2/bin $PATH

# Go
set -x GOROOT /usr/local/go
set -x GOPATH $HOME/go
set -x PATH $GOPATH/bin $GOROOT/bin $PATH

set -x PATH $HOME/.foundry/bin $PATH

# Editor
set -x EDITOR nvim


# FZF defaults
set -x FZF_DEFAULT_OPTS "--ansi --preview-window 'right:60%' --preview 'batcat --color=always --style=header,grid --line-range :300 {}'"

# abbr
abbr -a v nvim

abbr -a p pnpm
abbr -a vf 'nvim (fzf)'

abbr -a gd 'git status -s | fzf --no-sort --reverse --preview "git diff --color=always {+2}" --preview-window=right:60%:wrap'

# alias
alias startup='~/cscript/bin/startup'

fish_vi_key_bindings
# set -e fish_key_bindings

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH


fish_add_path $HOME/.local/share/coursier/bin


