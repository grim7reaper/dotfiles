zstyle :compinstall filename "$HOME/.zshrc"

# {{{ Colors

autoload -Uz colors
colors

# }}}
# {{{ Completion.

# Enable completion.
autoload -Uz compinit
compinit

# Enable completion caching.
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.cache/zsh

# Be verbose by default (e.g list process command lines instead of PID only).
zstyle ':completion:*' verbose yes
# Display different types of matches separately (e.g jobs and processes).
zstyle ':completion:*' group-name ''
# Propose ‘.’ and ‘..’ as possible completions.
zstyle ':completion:*' special-dirs true
# Display a selection menu when there is more than one match.
zstyle ':completion:*' menu select=2
# Display a short description of what the matches are above the matches list.
zstyle ':completion:*:descriptions' format "%B%d%b"
# Use the same colors as `ls` to display files in a list of matches.
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# Don't consider the files already on the line as possible completions.
zstyle ':completion:*:rm:*' ignore-line yes

# Display only my processes's PID and command.
zstyle ':completion:*:processes' command 'ps -u $USER -o pid,command'
# PID in blue, command in white
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=$color[white]=$color[blue]"

# }}}
# {{{ VCS info

autoload -Uz vcs_info
# Only git for now…
zstyle ':vcs_info:*' enable git
# Figure out the revision of the repository's work tree.
zstyle ':vcs_info:git*:*' get-revision true
# Show when the working directory has uncommitted changes in %c/%u.
zstyle ':vcs_info:git*:*' check-for-changes true
# Format used when there is action in the repository (merge conflict, …).
zstyle ':vcs_info:git*:*' actionformats "%F{yellow}%r%f [%F{red}%b%f] %F{green}%u%c%m%f (%a)"
# Format used when `actionformats` is not in use.
zstyle ':vcs_info:git*:*' formats       "%F{yellow}%r%f [%F{red}%b%f] %F{green}%u%c%m%f"
# Show count of stashed changes.
zstyle ':vcs_info:git*+set-message:*' hooks git-stash

# }}}
# {{{ Prompt

autoload -Uz promptinit
promptinit

# }}}
# {{{ Misc.

autoload -Uz terminfo

# Edit the command line with an external editor.
autoload edit-command-line
zle -N edit-command-line

# Enable coredump.
ulimit -c unlimited

# Disable XON/XOFF flow control (it interferes with C-s and C-q).
stty -ixon

# Use Emacs editing mod.
bindkey -e

# }}}

# For gpg-agent (otherwise pinentry-tty doesn't works).
export GPG_TTY=$(tty)

source "$ZSH_HOME/options"
source "$ZSH_HOME/aliases"
source "$ZSH_HOME/functions"

# Manage SSH keys in a convenient and secure manner.
eval `keychain -q --eval --agents ssh id_rsa`

# vim:fdm=marker:fdl=0
