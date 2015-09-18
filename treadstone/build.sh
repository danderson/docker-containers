#!/bin/sh

set -e

apk -U add ferm iproute2 iptables ip6tables openvpn sudo
apk upgrade

cd /tmp/treadstone
mkdir -p /treadstone
ferm --remote --domain ip firewall.conf >/treadstone/iptables.conf
ferm --remote --domain ip6 firewall.conf >/treadstone/ip6tables.conf
cp run.sh iproute2.sh route-up.sh /treadstone

adduser -S -s /bin/sh -u 1194 vpn
cat >/etc/sudoers <<EOF
root ALL=(ALL) ALL
vpn ALL=(ALL) NOPASSWD: /sbin/ip
EOF

# Cleanup
apk del ferm
cd /
rm -rf /tmp/treadstone
