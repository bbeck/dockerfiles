FROM jess/spotify
LABEL maintainer "Brandon Beck <bmbeck@gmail.com>"

# Add pulseaudio support
USER root
RUN apt-get update &&                                              \
    apt-get install -y pulseaudio-utils --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

USER spotify
