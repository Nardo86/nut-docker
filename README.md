# nut-docker

**NUT-SERVER**

This is a simple debian image with the nut-server package installed.
Image available at https://hub.docker.com/r/nardo86/nut-server

**USAGE**

Just run the image publishing the port and pointing to the ups device path. Use lsusb to find the current Bus and Device

`docker run -d -p 3493:3493 --name=Nut --restart unless-stopped --device=/dev/bus/usb/001/005 nardo86/nut-server`

All the settings for the UPS are customizable like the name, driver, Port, Polling frequency and the description using the enviroment variables.

It is also possibile to insert an user, for example it's possibile to make the service compatible with Synology NAS changing the USERSSTRING like

`-e USERSSTRING='[monuser] \n  password = secret \n  upsmon slave'`


**EXTRA OPTIONS**

Environment variable used for the configuration

Variable|Description|Default
--------|-----------|-------
NAME|a simple name for your ups|ups
DRIVER|the driver to use*|usbhid-ups
PORT|device port|auto
POLLFREQ|polling Interval|5
DESC|full description for your ups|UPS
USERSSTRING|single line users configuration|#

*see https://networkupstools.org/stable-hcl.html for compatibility list