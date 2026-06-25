#bash sourced

## Add some alias shorthands to save typing

# Usual 'kc'
alias kc=kubectl

# 'kcn' use current dir name as ns name
alias kcn='kubectl -n "$(basename $PWD)"'

