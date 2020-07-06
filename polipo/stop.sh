#!/bin/bash

if [[ "${WEBPROXY_ENABLED}" = "true" ]]; then

  /etc/init.d/polipo stop

fi
