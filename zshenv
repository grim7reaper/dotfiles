# {{{ XDG

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# {{{ XDG-compliance

export ZSH_HOME="$XDG_CONFIG_HOME/zsh"
export FETCHMAILHOME="$XDG_CONFIG_HOME/fetchmail"
export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"
export TASKRC="$XDG_CONFIG_HOME/taskwarrior/taskrc"

export LESSHISTFILE="$XDG_DATA_HOME/less/history"
export WINEPREFIX="$XDG_DATA_HOME/wine"

export DVDCSS_CACHE="$XDG_CACHE_HOME/dvdcss"

# }}}
# }}}
# {{{ PATH

OPT_PATHS=(
    "$HOME/.local/bin"              # Local binaries
    "$HOME/.gem/ruby/2.3.0/bin"     # Ruby gems
    "$HOME/.cabal/bin"              # Haskell packages
    "$HOME/.cargo/bin"              # Rust packages
    "$HOME/.rvm/bin"                # RVM
)

for path in $OPT_PATHS; do
    if [ -d "$path" ] ; then
        PATH=$PATH:$path
    fi
done

# Load RVM into a shell session *as a function*
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# }}}
# {{{ History

export HISTFILE="$XDG_DATA_HOME/zsh/history"
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE

# }}}
# {{{ Default software

export EDITOR=$(which vim)
export VISUAL=$EDITOR

export PAGER=$(which less)
export LESS=FRX

export BROWSER=$(which firefox)

# }}}
# {{{ Misc.

export HOST
# wine: I want 32-bit only because I play games only on Windows XP.
export WINEARCH=win32
# Java: aesthetic…
#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export _JAVA_AWT_WM_NONREPARENTING=1
# For pushd
export DIRSTACKSIZE=16

# }}}
# vim:fdm=marker:fdl=0
