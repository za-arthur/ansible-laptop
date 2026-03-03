if status is-interactive
    set fish_greeting ""

    # Homebrew
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

    # fzf integration
    if type -q fzf
        fzf --fish | source
    end

    # PostgreSQL
    fish_add_path "$HOME/.pgenv/pgsql/bin"
    fish_add_path "$HOME/.pgenv/bin"

    fish_add_path "$(brew --prefix)/opt/llvm/bin"

    # Other PATH

    fish_add_path "$HOME/.local/bin"
    fish_add_path "$HOME/.cargo/bin"

    set -Ux LDFLAGS "-L$(brew --prefix)/opt/icu4c/lib -L$(brew --prefix)/opt/openssl/lib -L$(brew --prefix)/opt/zstd/lib"
    set -Ux CPPFLAGS "-I$(brew --prefix)/opt/icu4c/include -I$(brew --prefix)/opt/openssl/include -I$(brew --prefix)/opt/zstd/include"
    set -Ux PKG_CONFIG_PATH "$(brew --prefix openssl)/lib/pkgconfig:$(brew --prefix icu4c)/lib/pkgconfig:$HOME/.pgenv/pgsql/lib/pkgconfig"

    # Python
    set -Ux PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin

    # Aliases
    alias ls="lsd"
    alias ll="ls -lh"

    # Fix tide "normal" icon
    set -U tide_character_vi_icon_default $tide_character_icon
end
