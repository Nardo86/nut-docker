#!/bin/bash
set -e

echo "Starting NUT Server..."
echo "UPS Name: $NAME"
echo "Driver: $DRIVER"
echo "Port: $PORT"
echo "Poll Frequency: $POLLFREQ seconds"

# Set timezone
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Configure UPS
echo "Configuring UPS..."
cat > /etc/nut/ups.conf << EOF
[$NAME]
    driver = $DRIVER
    port = $PORT
    pollfreq = $POLLFREQ
    desc = $DESC
EOF

# Configure users if provided
if [ "$USERSSTRING" != "#" ]; then
    echo "Configuring NUT users..."
    echo -e "$USERSSTRING" > /etc/nut/upsd.users
fi

# Set permissions for USB devices if they exist
if [ -d /dev/bus/usb ]; then
    echo "Setting USB device permissions..."
    chgrp nut /dev/bus/usb/*/* 2>/dev/null || echo "No USB devices found or permission already set"
fi

# Set correct permissions
chgrp nut /etc/nut/* 2>/dev/null || true

echo "Starting UPS driver..."
upsdrvctl start

echo "Starting UPS daemon..."
exec upsd -D