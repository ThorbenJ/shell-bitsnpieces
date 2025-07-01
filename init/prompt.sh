#!/bin/bash

# Prompt with a smilie =) if last commend succeded and a frowny :( if it failed
# Plus info I like to have with colour coding

# fancy prompt colours
pc_symbol="\e[97;40m"       #Symbol colours
pc_host="\e[93;40m"         #hostname colour
pc_user="\e[94;40m"         #username colour
pc_term="\e[95;40m"         #tty/pts base num colour
pc_cwd="\e[96;40m"          #current dir colour

alias rs="test \$? = 0 && echo -e \"\033[92;40m=)\" || echo -e \"\033[91;40m:(\""

# Touch with extreme caution, print/non-print chars carefully counted and balanced, so bash knows the correct prompt length
PS1="\[${pc_term}\]\l\[${pc_symbol}\]|\[${pc_user}\]\u\[${pc_symbol}@${pc_host}\]\h\[${pc_symbol}:${pc_cwd}\]\w \[\`rs\`\]\033[0m"

export PS1

