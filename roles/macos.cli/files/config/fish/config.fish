if status is-interactive
    set fish_greeting ""

    # Commands to run in interactive sessions can go here
    source $HOME/.orbstack/shell/init2.fish

    # PostgreSQL
    fish_add_path "$HOME/.pgenv/pgsql/bin"
    fish_add_path "$HOME/.pgenv/bin"

    # Homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"

    fish_add_path "/opt/homebrew/opt/gnu-getopt/bin"
    fish_add_path "/opt/homebrew/opt/llvm/bin"
    fish_add_path "/opt/homebrew/opt/grep/libexec/gnubin"

    # Other PATH

    fish_add_path "$HOME/.local/bin"
    fish_add_path "$HOME/.cargo/bin"

    set -Ux LDFLAGS "-L/opt/homebrew/opt/icu4c/lib -L/opt/homebrew/opt/openssl/lib -L/opt/homebrew/opt/zstd/lib"
    set -Ux CPPFLAGS "-I/opt/homebrew/opt/icu4c/include -I /opt/homebrew/opt/openssl/include -I/opt/homebrew/opt/zstd/include"
    set -Ux PKG_CONFIG_PATH "/opt/homebrew/opt/icu4c/lib/pkgconfig"

    set -Ux MACOSX_DEPLOYMENT_TARGET (sw_vers -productVersion)

    # Python
    set -Ux PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin

    # Aliases
    alias ls="lsd"
    alias ll="ls -lh"

    # Pure config
    set -U pure_show_system_time true
    set -U pure_show_subsecond_command_duration true

    set -U pure_symbol_virtualenv_prefix "🐍 "
    set -U pure_symbol_aws_profile_prefix "☁️ "

    set -U fish_transient_prompt 1
    set -U pure_enable_single_line_prompt true

    set -U pure_check_for_new_release true
end
