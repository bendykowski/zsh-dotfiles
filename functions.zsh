__export_aliases_prettyfied() {
    if [ -z $ALIASES_PRETTYFIED ]; then
        export ALIASES_PRETTYFIED="$(
            echo "$(alias)" | 
            sed "s/'\{0,1\}\([^?']*\)\?\{0,1\}'\{0,1\}='\{0,1\}\(echo ?:\)\{0,1\}\([^']*\)'\{0,1\}/\1 -> \3/g")"
    fi
}