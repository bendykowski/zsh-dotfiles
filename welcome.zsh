#!/usr/bin/evn zsh

rand=$(echo "$(alias)" | gshuf -n 1)

IFS='=' read -r prefix suffix <<< "$rand"

prefix=$(sed -e "s/^'//" -e "s/'$//" <<< "$prefix")
suffix=$(sed -e "s/^'//" -e "s/'$//" <<< "$suffix")
operation='of'

if [[ ${prefix:0:1} = "?" ]]; then
    prefix=${prefix:1}
    suffix=${suffix#echo :}
    operation='to'
fi

echo "
${bold_color}ALIAS TIP:${reset_color}
$fg[green]$prefix${reset_color} is the alias $operation $fg[red]$suffix${reset_color}"