if status is-interactive
    fish_hybrid_key_bindings
    if test -z "$CONTAINER_ID"
        starship init fish | source
    end
end

alias g lazygit
alias v nvim
alias ls eza
alias cat bat

set -Ux EDITOR nvim

fish_add_path ~/.cargo/bin
fish_add_path ~/Scripts
