Run spotify in a docker container with pulseaudio.

This container uses Jess Frazelle's [spotify docker image][1] as the
base container.

This container can be invoked like this:

```bash
# Make sure the config directory exists
if [[ ! -d ${HOME}/.config/spotify ]]; then
  mkdir -p ${HOME}/.config/spotify
  chmod 700 ${HOME}/.config/spotify
fi

# Make sure the cache directory exists
if [[ ! -d ${HOME}/.cache/spotify ]]; then
  mkdir -p ${HOME}/.cache/spotify
  chmod 755 ${HOME}/.cache/spotify
fi

# Create a temporary pulseaudio socket for spotify to use
SOCKET="$(
  pactl load-module             \
    module-native-protocol-unix \
    auth-anonymous=1            \
    socket=/tmp/.pulseaudio-spotify-$(id -u)
)"

# Make sure we remove the temporary socket when exiting
trap "pactl unload-module '${SOCKET}'" EXIT

# The id of the spotify user in the container.  This should remain consistent
# with the id in the Dockerfile.
USER_ID=1000

docker run --rm                                                        \
  --name spotify                                                       \
  -v /tmp/.X11-unix:/tmp/.X11-unix                                     \
  -v /etc/localtime:/etc/localtime:ro                                  \
  -v /etc/machine-id:/etc/machine-id                                   \
  -v /tmp/.pulseaudio-spotify-$(id -u):/tmp/.pulseaudio-spotify        \
  -v /var/lib/dbus:/var/lib/dbus                                       \
  -v /var/run/dbus:/var/run/dbus                                       \
  -v /var/run/user/$(id -u):/var/run/user/${USER_ID}                   \
  -v ${HOME}/.config/spotify:/home/spotify/.config/spotify             \
  -v ${HOME}/.cache/spotify:/home/spotify/.cache                       \
  -e DBUS_SESSION_BUS_ADDRESS="unix:path=/var/run/user/${USER_ID}/bus" \
  -e DISPLAY=unix${DISPLAY}                                            \
  -e PULSE_SERVER=/tmp/.pulseaudio-spotify                             \
  --device /dev/dri                                                    \
bbeck/spotify
```

[1]: https://github.com/jessfraz/dockerfiles/blob/master/spotify/Dockerfile

