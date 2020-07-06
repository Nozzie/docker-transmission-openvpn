# OpenVPN and Transmission with WebUI

Fork of haugene/transmission-openvpn, based on alpine linux. With Polipo instead of Tinyproxy.
Look at https://haugene.github.io/docker-transmission-openvpn/ for detailed instructions.
This container adds two new environment variables to configure the polipo disk cache.

WEBPROXY_DISK_CACHE_ENABLED=false/true to enable or disable the disk cache.

WEBPROXY_DISK_CACHE_DIR=/path/to/disk/cache cache location. For instance /data/polipo-cache, since you have to mount that
dir already anyway. Make sure the dir exists before you start the container, otherwise the disk cache will be disabled.


## Quick Start

This container contains OpenVPN and Transmission with a configuration
where Transmission is running only when OpenVPN has an active tunnel.
It bundles configuration files for many popular VPN providers to make the setup easier.

```
$ docker run --cap-add=NET_ADMIN -d \
              -v /your/storage/path/:/data \
              -v /etc/localtime:/etc/localtime:ro \
              -e CREATE_TUN_DEVICE=true \
              -e OPENVPN_PROVIDER=PIA \
              -e OPENVPN_CONFIG=CA\ Toronto \
              -e OPENVPN_USERNAME=user \
              -e OPENVPN_PASSWORD=pass \
              -e WEBPROXY_ENABLED=true \
              -e WEBPROXY_PORT=8888 \
              -e WEBPROXY_DISK_CACHE_ENABLED=true \
              -e WEBPROXY_DISK_CACHE_DIR=/data/polipo-cache \
              -e LOCAL_NETWORK=192.168.0.0/16 \
              --log-driver json-file \
              --log-opt max-size=10m \
              -p 9091:9091 \
              -p 8888:8888 \
              nozzie/transmission-openvpn-polipo
```

