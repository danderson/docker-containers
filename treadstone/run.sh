#!/bin/sh

set -e

cat >/etc/resolv.conf <<EOF
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF

# Replicate the non-VPN routing table to a private table used only by
# marked packets. Netfilter marks inbound connections to EXPOSEd ports
# with this mark, and this routing table makes the responses bypass
# the VPN.
ip route show | while read -r line; do
    ip route add table 100 $line
done
ip rule add fwmark 100 pref 100 table 100

iptables-restore </treadstone/iptables.conf
# IPv6 may not be around, depending on how docker is configured.
#ip6tables-restore </treadstone/ip6tables.conf || true

for portspec in $TREADSTONE_EXPOSE_PORTS; do
    proto=$(echo $portspec | cut -f1 -d'/')
    port=$(echo $portspec | cut -f2 -d'/')
    set -x
    iptables -A EXPOSED_PORTS -p $proto --dport $port -j CONNMARK --set-mark 100
    set +x
done

ip tuntap add dev vpn mode tun user vpn

# Poor man's Mutually Assured Destruction init. Run OpenVPN in a
# subshell, but kill whatever is keeping the container alive if it
# fails.
INIT=$$
(
    su -c "openvpn --config ${TREADSTONE_VPN_CONFIG} --iproute /treadstone/iproute2.sh --route-noexec --route-up /treadstone/route-up.sh --script-security 2 --port 1194" vpn
    kill -9 $INIT
)&

while [ ! -f /tmp/vpn-up ]; do
    sleep 1
done

if [ "$#" = "0" ]; then
    exec /bin/sh
else
    exec $@
fi
