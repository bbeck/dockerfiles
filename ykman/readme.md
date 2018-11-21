Run ykman in a docker container.

This container uses Jess Frazelle's [ykman docker image][1] as the
base container.

This container can be invoked like this:

```bash
docker run -it --rm     \
  --name ykman          \
  --device /dev/bus/usb \
  --device /dev/usb     \
bbeck/ykman
```

[1]: https://github.com/jessfraz/dockerfiles/blob/master/ykman/Dockerfile

