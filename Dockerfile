FROM docker.io/steamcmd/steamcmd:latest
ENV HOME /home/css
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

# Add normal user to run server under
RUN useradd -m css

# Install dependencies
RUN apt update && \
    apt install --no-install-recommends --no-install-suggests -y sudo iproute2 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Fix permissions
RUN chown css:css /server

# Add files
COPY --chmod=755 --chown=css:css entrypoint.sh /

# Allow anyone to read/write to /home/css/.steam so any user can run the server
RUN mkdir ${HOME}/.steam \
    && chown -R css:css ${HOME}/.steam \
    && chmod -R 777 ${HOME}

USER css

VOLUME [ "/server" ]
HEALTHCHECK --interval=10s --start-period=30s --retries=3 CMD if [ $(ss -l | grep -c LISTEN.*27015) == "0" ] ; then exit 1; fi
ENTRYPOINT [ "/entrypoint.sh" ]