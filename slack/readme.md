Run spotify in a docker container with pulseaudio.

This container uses Jess Frazelle's [slack docker image][1] as the
base container.

This container can be invoked like this:

```bash
# Create a temporary pulseaudio socket for slack to use
SOCKET="$(
  pactl load-module             \
    module-native-protocol-unix \
    auth-anonymous=1            \
    socket=/tmp/.pulseaudio-slack-$(id -u)
)"

# Make sure we remove the temporary socket when exiting
trap "pactl unload-module '${SOCKET}'" EXIT

docker run --rm                                                  \
  --name slack                                                   \
  -v /tmp/.X11-unix:/tmp/.X11-unix                               \
  -v /etc/localtime:/etc/localtime:ro                            \
  -v /etc/machine-id:/etc/machine-id                             \
  -v /tmp/.pulseaudio-slack-$(id -u):/tmp/.pulseaudio-slack      \
  -v /var/lib/dbus:/var/lib/dbus                                 \
  -v /var/run/dbus:/var/run/dbus                                 \
  -v /var/run/user/$(id -u):/var/run/user/1000                   \
  -v $HOME/.config/slack:/home/slack/.config/Slack               \
  -e DBUS_SESSION_BUS_ADDRESS="unix:path=/var/run/user/1000/bus" \
  -e DISPLAY=unix${DISPLAY}                                      \
  -e PULSE_SERVER=/tmp/.pulseaudio-slack                         \
  --device /dev/dri                                              \
  --ipc host                                                     \
bbeck/slack
```

[1]: https://github.com/jessfraz/dockerfiles/blob/master/slack/Dockerfile

