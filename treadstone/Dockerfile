FROM alpine:edge

ENV VPN_CONFIG_PATH="/openvpn.conf"

COPY . /tmp/treadstone
RUN /tmp/treadstone/build.sh
ENTRYPOINT /treadstone/run.sh
