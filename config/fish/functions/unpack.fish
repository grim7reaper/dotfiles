function unpack -d "Extract archives or uncompress files"
    if test -f "$argv[1]"
        switch $argv[1]
            case '*.tar.gz'
                tar xvzf "$argv[1]"
            case '*.tar.bz2'
                tar xvjf "$argv[1]"
            case '*.tar.xz'
                tar xvJf "$argv[1]"
            case '*.tar.Z'
                tar xvZf "$argv[1]"
            case '*.tar'
                tar xvf "$argv[1]"
            case '*.tgz'
                tar xvzf "$argv[1]"
            case '*.zip'
                unzip "$argv[1]"
            case '*.gz'
                gunzip "$argv[1]"
            case '*.bz2'
                bunzip2 "$argv[1]"
            case '*.xz'
                unxz "$argv[1]"
            case '*.rar'
                unrar "$argv[1]"
            case '*.Z'
                uncompress "$argv[1]"
            case '*.7z'
                7zz x "$argv[1]"
            case '*.lzo'
                lzop -x "$argv[1]"
            case '*.lzma'
                unlzma "$argv[1]"
            case '*.cb7'
                7zz x "$argv[1]"
            case '*.cbr'
                unrar "$argv[1]"
            case '*.cbt'
                tar xvf "$argv[1]"
            case '*.cbz'
                unzip "$argv[1]"
            case '*'
                echo "'$argv[1]' cannot be extracted via unpack()"
        end
    else
         echo "'$argv[1]' is not a valid archive file"
    end
end

