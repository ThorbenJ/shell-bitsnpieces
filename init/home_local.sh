#bash sourced

## Setup $HOME/Local as the place to install user local programmes

prepend_path() {
    local varname="$1"
    local newpath="$2"
    local oldvalue="${!varname}"

    # Parent dir doesn't exist
    [[ -d "$(dirname $newpath)" ]] || return

    # Aleady in path
    [[ ":$oldvalue:" == *":$newpath:"* ]] && return

    if [[ -z "$oldvalue" || "$oldvalue" == ":" ]]; then
        export "$varname"="$newpath$oldvalue"
    else
        export "$varname"="$newpath:$oldvalue"
    fi
}

if [[ -z "$MANPATH" ]]; then
    #trailing colon should cause man to auto include system paths
    export MANPATH=":"
fi

# Setup ~/Local as the place to find things
prepend_path PATH              "$HOME/Local/bin"
prepend_path PERL5LIB          "$HOME/Local/lib/perl5"
prepend_path GOPATH            "$HOME/Local/lib/go"
prepend_path MANPATH           "$HOME/Local/share/man"
prepend_path LD_LIBRARY_PATH   "$HOME/Local/lib"
prepend_path PKG_CONFIG_PATH   "$HOME/Local/lib/pkgconfig"
prepend_path PYTHONPATH        "$HOME/Local/lib/python"

export GOBIN="$HOME/Local/bin"

