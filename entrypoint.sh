#!/bin/bash

sed -i 's/MODE=none/MODE=netserver/g' /etc/nut/nut.conf
echo "LISTEN 0.0.0.0 3493" >> /etc/nut/upsd.conf
echo -e "[$NAME] \n  driver = $DRIVER \n  port = $PORT \n  pollfreq = $POLLFREQ \n  desc = $DESC" >> /etc/nut/ups.conf
echo -e "$USERSSTRING" >> /etc/nut/upsd.users

chgrp nut /etc/nut/*
chgrp nut /dev/bus/usb/*/*

upsdrvctl start

exec upsd -D