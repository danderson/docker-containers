FROM alpine
RUN apk -U add libvirt-daemon libvirt-qemu qemu qemu-x86_64 qemu-system-x86_64 && rm -rf /var/cache/apk/*
COPY libvirtd.conf /etc/libvirt/libvirtd.conf
ENTRYPOINT ["/usr/sbin/libvirtd"]
