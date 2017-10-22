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
    "$HOME/.gem/ruby/2.4.0/bin"     # Ruby gems
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

export LS_COLORS='di=1;34:fi=0:ln=0;1;44:pi=40;33:so=01;35:bd=1;33:cd=1;33:or=5;1;31:mi=0:ex=1;32'

# }}}
# vim:fdm=marker:fdl=0
