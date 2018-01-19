# {{{ PATH

OPT_PATHS=(
    "$HOME/.local/bin"              # Local binaries
    "$HOME/.gem/ruby/2.5.0/bin"     # Ruby gems
    "$HOME/.cabal/bin"              # Haskell packages
    "$HOME/.cargo/bin"              # Rust packages
)

for opt_path in $OPT_PATHS; do
    if [ -d "$opt_path" ] ; then
        PATH=$PATH:$opt_path
    fi
done
export PATH

# }}}
