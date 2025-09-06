FROM docker.io/steamcmd/steamcmd:latest
ENV REPLACE_MOUNT_CONFIG true
ENV MAX_PLAYERS 32
ENV GAME_MODE sandbox
ENV MAP cs_office
ENV WORKSHOP_COLLECTION=
ENV LOCATION=
ENV PASSWORD=
ENV LOGIN_TOKEN=
ENV ARGS=

WORKDIR /server

# Add files
COPY --chmod=755 entrypoint.sh /

VOLUME [ "/server" ]
ENTRYPOINT [ "/entrypoint.sh" ]