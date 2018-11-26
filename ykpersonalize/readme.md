Run ykpersonalize in a docker container.

This container uses Jess Frazelle's [ykpersonalize docker image][1] as the
base container.

This container can be invoked like this:

```bash
docker run -it --rm     \
  --name ykpersonalize  \
  --device /dev/bus/usb \
  --device /dev/usb     \
bbeck/ykpersonalize
```

[1]: https://github.com/jessfraz/dockerfiles/blob/master/ykpersonalize/Dockerfile

