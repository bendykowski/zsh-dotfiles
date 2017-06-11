#!/usr/bin/evn zsh

__welcome_screen() {
    local alias
    __export_aliases_prettyfied

    alias="$(
        echo $ALIASES_PRETTYFIED | 
        gshuf -n 1 | 
        sed "s/\(.*\) -> \(.*\)/$fg[green]\1${reset_color} is the alias for $fg[red]\2${reset_color}/g")"

    echo "
${bold_color}ALIAS TIP:${reset_color}
    $alias"
}

__welcome_screen