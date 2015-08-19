FROM alpine
RUN apk -U add libvirt-daemon libvirt-qemu qemu-kvm && rm -rf /var/cache/apk/*
ENTRYPOINT ["/usr/sbin/libvirtd"]
