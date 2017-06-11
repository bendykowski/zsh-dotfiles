dotfiles_export_aliases_prettyfied() {
    if [ -z $dotfiles_aliases_prettyfied ]; then
        export dotfiles_aliases_prettyfied="$(
            echo "$(alias)" | 
            sed "s/'\{0,1\}\([^?']*\)\?\{0,1\}'\{0,1\}='\{0,1\}\(echo ?:\)\{0,1\}\([^']*\)'\{0,1\}/\1 -> \3/g")"
    fi
}