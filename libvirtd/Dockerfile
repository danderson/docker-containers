FROM alpine
RUN apk -U add libvirt-daemon libvirt-qemu qemu && rm -rf /var/cache/apk/*
ENTRYPOINT ["/usr/sbin/libvirtd"]
