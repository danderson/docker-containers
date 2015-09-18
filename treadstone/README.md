To run a treadstone container, you need to give it CAP_NET_ADMIN and
access to the /dev/net/tun device:

```shell
docker run --cap-add=NET_ADMIN --device=/dev/net/tun treadstone your_command_here
```

The container entrypoint will wait for the VPN to initially come up
before running your command. If you just need a shell to play with,
run the container with no arguments:

```shell
docker run -it --cap-add=NET_ADMIN --device=/dev/net/tun treadstone
```
