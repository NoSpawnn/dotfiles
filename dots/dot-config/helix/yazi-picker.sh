#!/usr/bin/env bash

# https://yazi-rs.github.io/docs/tips/#helix-with-zellij
# https://github.com/zellij-org/zellij/issues/3018#issuecomment-3704307035

paths=$(yazi "$2" --chooser-file=/dev/stdout)

if [[ -n "$paths" ]]; then
	zellij action toggle-floating-panes
	zellij action write 27 # send <Escape> key
	zellij action write-chars ":$1 $paths"
	zellij action write 13 # send <Enter> key
else
	zellij action toggle-floating-panes
fi
