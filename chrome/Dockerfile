FROM jess/chrome:stable
LABEL maintainer "Brandon Beck <bmbeck@gmail.com>"

USER root

# Change the user/group to have GID=1000 and UID=1000 which corresponds
# to the host user's ids.
ENV USER_HOME=/home/chrome
ENV USER_ID=1000
ENV USER_GID=1000

# The group id 986 corresponds to the host's video group id.
ENV VIDEO_GID=986

RUN groupadd --gid $VIDEO_GID hostvideo \
      && groupmod --gid $USER_GID chrome \
      && usermod --uid $USER_ID chrome \
      && gpasswd -a chrome hostvideo \
      && chown -R chrome:chrome $USER_HOME

USER chrome
