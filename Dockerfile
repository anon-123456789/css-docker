FROM docker.io/steamcmd/steamcmd:latest
ENV MAX_PLAYERS 32
ENV MAP cs_office
ENV PASSWORD=
ENV LOGIN_TOKEN=
ENV ARGS=

WORKDIR /server

# Add files
COPY --chmod=755 entrypoint.sh /

VOLUME [ "/server" ]
ENTRYPOINT [ "/entrypoint.sh" ]