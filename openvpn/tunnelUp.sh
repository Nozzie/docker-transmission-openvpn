#!/bin/bash

/etc/transmission/start.sh "$@"
[[ ! -f /etc/polipo/start.sh ]] || /etc/polipo/start.sh
