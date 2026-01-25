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

    if test -r "$HOME/.opam/opam-init/init.fish"
        source "$HOME/.opam/opam-init/init.fish"
    end

    if test -f /home/codeshaine/.ghcup/env.fish
        source /home/codeshaine/.ghcup/env.fish
    end

    fzf --fish | source

    starship init fish | source

    direnv hook fish | source

    zoxide init fish | source

end

function fish_command_not_found
    __fish_default_command_not_found_handler $argv
end

set -U fish_greeting 


fish_add_path $HOME/bin 
fish_add_path $HOME/.local/bin 
fish_add_path /usr/local/bin 

fish_add_path $HOME/.zig/zig-0.15.2/bin 

set -x GOROOT /usr/local/go
set -x GOPATH $HOME/go
fish_add_path $GOROOT/bin 
fish_add_path $GOPATH/bin

fish_add_path $HOME/.foundry/bin 

set -x EDITOR nvim

set -x FZF_DEFAULT_OPTS "--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'"

abbr -a v nvim
abbr -a p pnpm
abbr -a vf 'nvim (fzf)'
abbr -a gd 'git status -s | fzf --no-sort --reverse --preview "git diff --color=always {+2}" --preview-window=right:60%:wrap'

alias startup='~/cscript/bin/startup'

fish_vi_key_bindings
# set -e fish_key_bindings

set --export BUN_INSTALL "$HOME/.bun"
fish_add_path $BUN_INSTALL/bin 

fish_add_path $HOME/.local/share/coursier/bin


fish_add_path /opt/riscv/xpack-riscv-none-elf-gcc-15.2.0-1/bin

fish_add_path $HOME/.cargo/bin
