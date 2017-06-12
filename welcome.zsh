#!/usr/bin/evn zsh

dotfiles_welcome_screen() {
    local alias
    dotfiles_export_aliases_prettyfied

    alias="$(
        echo $dotfiles_aliases_prettyfied | 
        gshuf -n 1 | 
        sed -E "s/(.*) -> (.*)/$fg[green]\1${reset_color} is the alias for $fg[red]\2${reset_color}/g")"

    echo "
${bold_color}ALIAS TIP:${reset_color}
    $alias"
}

dotfiles_welcome_screen