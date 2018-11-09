FROM jess/slack
LABEL maintainer "Brandon Beck <bmbeck@gmail.com>"

# Add libnotify and pulseaudio support
RUN apt-get update &&                                              \
    apt-get install -y libnotify-bin  --no-install-recommends &&   \
    apt-get install -y pulseaudio-utils --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

ENV HOME=/home/slack

# The group id 986 corresponds to the host's video group id.
ENV VIDEO_GID=986

RUN groupadd --gid $VIDEO_GID hostvideo \
      && useradd --create-home --home-dir $HOME --uid 1000 slack \
      && gpasswd -a slack hostvideo \
      && chown -R slack:slack $HOME

WORKDIR $HOME
USER slack

