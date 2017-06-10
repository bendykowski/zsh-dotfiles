#!/usr/bin/env zsh

# find alias
falias() {
    params="$@"
    alias | grep "$params"
}