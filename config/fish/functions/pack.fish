function pack -d "Create archives or compress files"
    switch $argv[1]
        case '*.tar.gz'
            tar cvzf "$argv[1]" (string replace -r '\.tar\.gz$' '' $argv[1])
        case '*.tar.bz2'
            tar cvjf "$argv[1]" (string replace -r '\.tar\.bz2$' '' $argv[1])
        case '*.tar.xz'
            tar cvJf "$argv[1]" (string replace -r '\.tar\.xz2$' '' $argv[1])
        case '*.tar.Z'
            tar cvZf "$argv[1]" (string replace -r '\.tar\.Z$' '' $argv[1])
        case '*.tar'
            tar cvf "$argv[1]" (path change-extension '' $argv[1])
        case '*.tgz'
            tar cvzf "$argv[1]" (path change-extension '' $argv[1])
        case '*.zip'
            zip -r "$argv[1]" (path change-extension '' $argv[1])
        case '*.gz'
            gzip (path change-extension '' $argv[1])
        case '*.bz2'
            bzip2 (path change-extension '' $argv[1])
        case '*.xz'
            xz (path change-extension '' $argv[1])
        case '*.rar'
            rar a (path change-extension '' $argv[1])
        case '*.Z'
            compress (path change-extension '' $argv[1])
        case '*.7z'
            7zz a (path change-extension '' $argv[1])
        case '*.lzo'
            lzop -v  (path change-extension '' $argv[1])
        case '*.lzma'
            lzma -v (path change-extension '' $argv[1])
        case '*.cb7'
            7zz a (path change-extension '' $argv[1])
        case '*.cbr'
            rar a (path change-extension '' $argv[1])
        case '*.cbt'
            tar cvf "$argv[1]" (path change-extension '' $argv[1])
        case '*.cbz'
            zip -r "$argv[1]" (path change-extension '' $argv[1])
        case '*'
            echo "'$argv[1]' cannot be archived via pack()"
    end
end
