#!/bin/bash

chgrp nut /dev/bus/usb/*/*
upsdrvctl start
exec upsd -D