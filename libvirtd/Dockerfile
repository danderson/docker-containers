FROM alpine
RUN apk -U add libvirt-daemon libvirt-qemu qemu qemu-x86_64 && rm -rf /var/cache/apk/*
ENTRYPOINT ["/usr/sbin/libvirtd"]
