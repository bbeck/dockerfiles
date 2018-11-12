FROM jess/slack
LABEL maintainer "Brandon Beck <bmbeck@gmail.com>"

# Add libnotify and pulseaudio support
RUN apt-get update &&                                              \
    apt-get install -y libnotify-bin  --no-install-recommends &&   \
    apt-get install -y pulseaudio-utils --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Change the user/group to have GID=1000 and UID=1000 which corresponds
# to the host user's ids.
ENV USER_HOME=/home/slack
ENV USER_ID=1000
ENV USER_GID=1000

# The group id 986 corresponds to the host's video group id.
ENV VIDEO_GID=986

RUN groupadd --gid $VIDEO_GID hostvideo \
      && groupadd --gid $USER_GID slack \
      && useradd --create-home --home-dir $USER_HOME --uid $USER_ID --gid $USER_GID slack \
      && gpasswd -a slack hostvideo \
      && chown -R slack:slack $USER_HOME

WORKDIR $USER_HOME
USER slack

