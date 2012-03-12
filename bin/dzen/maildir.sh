#!/bin/zsh
fmail()  {
    local -A counts; local i

    for i in "${MAILDIR:-${HOME}/Mail}"/**/new/*
        { (( counts[${i:h:h:t}]++ )) }
    for i in ${(k)counts}
        { print -n $i: $counts[$i]' ' }
}

fmail
