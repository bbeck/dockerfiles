FROM jess/slack
LABEL maintainer "Brandon Beck <bmbeck@gmail.com>"

# Add libnotify and pulseaudio support
RUN apt-get update &&                                              \
    apt-get install -y libnotify-bin  --no-install-recommends &&   \
    apt-get install -y pulseaudio-utils --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

ENV HOME=/home/slack
RUN useradd --create-home --home-dir $HOME slack \
      && gpasswd -a slack audio \
      && chown -R slack:slack $HOME

WORKDIR $HOME
USER slack

ENTRYPOINT ["/usr/lib/slack/slack"]
