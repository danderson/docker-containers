#!/bin/sh

DEFAULTGW=$(ip route show | egrep '^default via ' | cut -f3 -d' ')

sudo /sbin/ip route add ${trusted_ip}/32 via ${DEFAULTGW}
sudo /sbin/ip route del default
# Hat trick: keep the old default gateway around, with a lower
# metric. If OpenVPN gets sad, it'll bring down the tunnel interface,
# which will restore the normal default route and keep everything
# happy.
sudo /sbin/ip route add default metric 2 via ${DEFAULTGW}
sudo /sbin/ip route add default metric 1 via ${route_vpn_gateway}
touch /tmp/vpn-up
