#!/bin/bash

# Install/update CSS
echo "Installing CSS Server..."
steamcmd +force_install_dir /server +login anonymous +app_update 232330 -validate +quit
echo "Done!"

echo "Adding root symlink..."
ln -sf /root/.steam/ /home/css/.steam/

# Replace mount.cfg
if [ "$REPLACE_MOUNT_CONFIG" = "true" ]; then
    echo "Replacing GMod mount.cfg..."
    cp /mount.cfg /server/garrysmod/cfg/mount.cfg
    echo "Done!"
fi

# Assemble arguments
if [ -n "$PASSWORD" ]
then
    ARGS="+sv_password $PASSWORD $ARGS"
fi

if [ -n "$LOGIN_TOKEN" ]
then
    ARGS="+sv_setsteamaccount $LOGIN_TOKEN $ARGS"
fi

ARGS="-strictportbind -port ${PORT:=27015} -game cstrike -maxplayers ${MAX_PLAYERS} +map ${MAP} +sv_lan 0 ${ARGS}"

# Start the server
echo "Starting server..."
/server/srcds_run $ARGS
echo "Finished!"
