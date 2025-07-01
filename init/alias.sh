#!/bin/bash

# Usual 'kc'
alias kc=kubectl

# 'kcn' use current dir name as ns name
alias kcn='kubectl -n "$(basename $PWD)"'

