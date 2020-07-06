#!/bin/bash

# Source our persisted env variables from container startup
. /etc/transmission/environment-variables.sh

find_proxy_conf()
{
    if [[ -f /etc/polipo.conf ]]; then
      PROXY_CONF='/etc/polipo.conf'
    elif [[ -f /etc/polipo/polipo.conf ]]; then
      PROXY_CONF='/etc/polipo/polipo.conf'
    else
     echo "ERROR: Could not find polipo config file. Exiting..."
     exit 1
    fi
}

set_port()
{
  expr $1 + 0 1>/dev/null 2>&1
  status=$?
  if test ${status} -gt 1
  then
    echo "Port [$1]: Not a number" >&2; exit 1
  fi

  # Port: Specify the port which polipo will listen on.  Please note
  # that should you choose to run on a port lower than 1024 you will need
  # to start polipo using root.

  if test $1 -lt 1024
  then
    echo "polipo: $1 is lower than 1024. Ports below 1024 are not permitted.";
    exit 1
  fi

  echo "Setting polipo port to $1";
  #sed -i -e"s,^Port .*,Port $1," $2
  sed -i -e "s/PORT/$1/" $2
}

if [[ "${WEBPROXY_ENABLED}" = "true" ]]; then

  echo "STARTING POLIPO"

  find_proxy_conf
  echo "Found config file $PROXY_CONF, updating settings."

  set_port ${WEBPROXY_PORT} ${PROXY_CONF}

  if [[ "${WEBPROXY_DISK_CACHE_ENABLED}" = "true" ]]; then
    echo "Enabling Polipo disk cache at ${WEBPROXY_DISK_CACHE_DIR}"
    echo "diskCacheRoot=${WEBPROXY_DISK_CACHE_DIR}" >> ${PROXY_CONF}
  fi

  /usr/bin/polipo -c ${PROXY_CONF}
  echo "polipo startup script complete."

fi
