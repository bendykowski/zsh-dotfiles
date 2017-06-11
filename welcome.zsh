#!/usr/bin/evn zsh

__welcome_screen() {
    local alias

    alias="$(
        echo "$(alias)" | 
        gshuf -n 1 | 
        sed "s/'\{0,1\}\([^?']*\)\?\{0,1\}'\{0,1\}='\{0,1\}\(echo ?:\)\{0,1\}\([^']*\)'\{0,1\}/$fg[green]\1${reset_color} is the alias for $fg[red]\3${reset_color}/g")"

    echo "
${bold_color}ALIAS TIP:${reset_color}
    $alias"
}

__welcome_screen