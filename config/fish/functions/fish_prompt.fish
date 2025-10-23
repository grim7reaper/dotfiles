function fish_prompt -d "Write out the prompt"
    set -g __fish_git_prompt_showdirtystate true
    set -g __fish_git_prompt_showstashstate true
    set -g __fish_git_prompt_showcolorhints true
    set -l cwd (string shorten -l -m 26 (prompt_pwd -d 0))

    printf '[%s%s%s@%s%s %s%s%s] %% %s' \
        (set_color -o red) $USER              \
        (set_color white)                     \
        (set_color -o normal) (hostname -s)   \
        (set_color -o yellow) $cwd            \
        (set_color -o white)                  \
        (set_color normal)
end
