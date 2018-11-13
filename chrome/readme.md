Run chrome in a docker container.

This container uses Jess Frazelle's [chrome docker image][1] as the
base container.  This container also requires a [custom
seccomp profile][2] to run correctly as well.

This container can be invoked like this:

```bash
# Make sure the config directory exists
if [[ ! -d ${HOME}/.config/google-chrome ]]; then
  mkdir -p ${HOME}/.config/google-chrome
  chmod 700 ${HOME}/.config/google-chrome
fi

# Make sure the seccomp profile exists
if [[ ! -e ${HOME}/.config/google/seccomp.json ]]; then
  URL="https://raw.githubusercontent.com/jfrazelle/dotfiles/master/etc/docker/seccomp/chrome.json"
  curl -L -o ${HOME}/.config/google-chrome/seccomp.json "${URL}"
fi


# Create a temporary pulseaudio socket for chrome to use
SOCKET="$(
  pactl load-module             \
    module-native-protocol-unix \
    auth-anonymous=1            \
    socket=/tmp/.pulseaudio-chrome-$(id -u)
)"

# Make sure we remove the temporary socket when exiting
trap "pactl unload-module '${SOCKET}'" EXIT

# The id of the chrome user in the container.  This should remain consistent
# with the id in the Dockerfile.
USER_ID=1000

docker run --rm                                                        \
  --name chrome                                                        \
  -v /dev/shm:/dev/shm                                                 \
  -v /etc/hosts:/etc/hosts                                             \
  -v /etc/localtime:/etc/localtime:ro                                  \
  -v /etc/machine-id:/etc/machine-id                                   \
  -v /tmp/.pulseaudio-chrome-$(id -u):/tmp/.pulseaudio-chrome          \
  -v /tmp/.X11-unix:/tmp/.X11-unix                                     \
  -v /var/lib/dbus:/var/lib/dbus                                       \
  -v /var/run/dbus:/var/run/dbus                                       \
  -v /var/run/user/$(id -u):/var/run/user/${USER_ID}                   \
  -v ${HOME}/.config/google-chrome:/home/chrome/.config/google-chrome  \
  -e DBUS_SESSION_BUS_ADDRESS="unix:path=/var/run/user/${USER_ID}/bus" \
  -e DISPLAY=unix${DISPLAY}                                            \
  -e PULSE_SERVER=/tmp/.pulseaudio-chrome                              \
  --security-opt seccomp:$HOME/.config/google-chrome/seccomp.json      \
  --device /dev/dri                                                    \
  --device /dev/video0                                                 \
  --ipc host                                                           \
bbeck/chrome                                                           \
  --user-data-dir=/home/chrome/.config/google-chrome
```

[1]: https://github.com/jessfraz/dockerfiles/blob/master/chrome/stable/Dockerfile
[2]: https://github.com/jessfraz/dotfiles/blob/master/etc/docker/seccomp/chrome.json

