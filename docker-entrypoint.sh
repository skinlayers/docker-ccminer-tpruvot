#!/bin/bash
set -e

# if command starts with an option, prepend ccminer
if [ "${1:0:1}" = '-' ]; then
    set -- /usr/local/bin/ccminer "$@"
fi

exec "$@"
