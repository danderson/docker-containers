#!/bin/sh

set -e

cat >/etc/resolv.conf <<EOF
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF

iptables-restore </treadstone/iptables.conf
# IPv6 may not be around, depending on how docker is configured.
#ip6tables-restore </treadstone/ip6tables.conf || true

ip tuntap add dev vpn mode tun user vpn

su -c "openvpn --config ${VPN_CONFIG_PATH} --iproute /treadstone/iproute2.sh --route-noexec --route-up /treadstone/route-up.sh --script-security 2 --port 1194" vpn &

while [ ! -f /tmp/vpn-up ]; do
    sleep 1
done

echo $#
if [ "$#" = "0" ]; then
    exec /bin/sh
else
    exec $@
fi
