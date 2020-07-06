#!/bin/bash

/etc/transmission/stop.sh
[[ ! -f /etc/polipo/stop.sh ]] || /etc/polipo/stop.sh
