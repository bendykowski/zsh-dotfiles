dotfiles_export_aliases_prettyfied() {
    if [ -z $dotfiles_aliases_prettyfied ]; then
        export dotfiles_aliases_prettyfied="$(
            echo "$(alias)" | 
            sed -E "s/^'?([^?']*)\??'?='?(echo )?([^']*)'?$/\1 -> \3/g")"
    fi
}

detect_os() {
    if [[ "$(uname)" == "Darwin" ]]; then
        echo "macos"
    elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
        echo "linux"
    else
        echo "unknown"
    fi
}