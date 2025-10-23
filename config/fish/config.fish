if status is-interactive
    # Environment variables {{{
    # XDG {{{

    set -gx XDG_DATA_HOME "$HOME/.local/share"
    set -gx XDG_CONFIG_HOME "$HOME/.config"
    set -gx XDG_CACHE_HOME "$HOME/.cache"

    # XDG-compliance {{{

    set -gx ZSH_HOME "$XDG_CONFIG_HOME/zsh"
    set -gx FETCHMAILHOME "$XDG_CONFIG_HOME/fetchmail"
    set -gx MPLAYER_HOME "$XDG_CONFIG_HOME/mplayer"
    set -gx TASKRC "$XDG_CONFIG_HOME/taskwarrior/taskrc"
    set -gx TIMEWARRIORDB "$XDG_DATA_HOME/timewarrior"

    set -gx LESSHISTFILE "$XDG_DATA_HOME/less/history"
    set -gx WINEPREFIX "$XDG_DATA_HOME/wine"

    set -gx DVDCSS_CACHE "$XDG_CACHE_HOME/dvdcss"

    # }}}
    # }}}
    # Default software {{{

    set -gx EDITOR (which vim)
    set -gx VISUAL "$EDITOR"

    set -gx PAGER 'less -FRX'

    set -gx BROWSER (which firefox)

    # }}}
    # }}}
    # PATH {{{

    set -gx GOPATH "$HOME/.golang"

    set -l OPT_PATHS  "$HOME/.local/bin"            # Local binaries
    set -la OPT_PATHS "$HOME/.gem/ruby/3.0.0/bin"   # Ruby gems
    set -la OPT_PATHS "$HOME/.cabal/bin"            # Haskell packages
    set -la OPT_PATHS "$HOME/.cargo/bin"            # Rust packages
    set -la OPT_PATHS "$GOPATH/bin"                 # Go packages
    set -la OPT_PATHS "/opt/homebrew/bin"           # Brew packages
    set -la OPT_PATHS "/opt/homebrew/opt/libpq/bin" # psql

    for opt_path in $OPT_PATHS
        if test -d "$opt_path"
            fish_add_path $opt_path
        end
    end

    # The next line updates PATH for the Google Cloud SDK.
    if test -f '/Users/sylvain/google-cloud-sdk/path.fish.inc'
        . '/Users/sylvain/google-cloud-sdk/path.fish.inc'
    end

    # }}}
    # Aliases {{{

    abbr -a bc bc --mathlib
    abbr -a dfc dfc -l -t apfs
    abbr -a x chmod u+x
    abbr -a g git
    abbr -a gg git grep
    abbr -a grep grep --color=auto
    abbr -a ls ls -G
    abbr -a ll ls -lh
    abbr -a la ls -A
    abbr -a lla ls -lhA
    abbr -a t tig
    abbr -a v vim

    # }}}

    # Enable coredump.
    ulimit -c unlimited
    # Disable XON/XOFF flow control (it interferes with C-s and C-q).
    stty -ixon
end
