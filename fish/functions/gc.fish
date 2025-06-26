function gc --description 'Interactive git branch checkout with fzf'
    if command -q fzf
        set branch (git branch | fzf)
        if test -n "$branch"
            git checkout (echo $branch | string trim)
        end
    else
        echo "fzf is required for this function"
        return 1
    end
end