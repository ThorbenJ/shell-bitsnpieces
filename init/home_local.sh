#!/bin/bash

# Setup ~/Local as the place to find things


PERL5LIB=$HOME/Local/lib/perl5:$PERL5LIB
GOPATH=$HOME/Local/lib/go
PATH=$HOME/Local/bin:$PATH

export PERL5LIB GOPATH PATH
