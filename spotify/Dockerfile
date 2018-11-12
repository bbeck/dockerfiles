FROM jess/spotify
LABEL maintainer "Brandon Beck <bmbeck@gmail.com>"

# Add pulseaudio support
USER root
RUN apt-get update &&                                              \
    apt-get install -y pulseaudio-utils --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Change the user/group to have GID=1000 and UID=1000 which corresponds
# to the host user's id.
ENV USER_HOME=/home/spotify
ENV USER_ID=1000
ENV USER_GID=1000

RUN groupmod -g $USER_GID spotify \ 
      && usermod --uid $USER_ID --gid $USER_GID spotify \
      && chown -R spotify:spotify $USER_HOME

WORKDIR $USER_HOME
USER spotify
