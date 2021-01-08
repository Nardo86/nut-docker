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

**NAME**		a simple name for your ups 		(default: ups)

**DRIVER**		the driver to use*				(default: usbhid-ups)

**PORT**		device port 					(default: auto)

**POLLFREQ**	polling Interval 				(default: 5)

**DESC**		full description for your ups  	(default: UPS)

**USERSSTRING**	single line users configuration	(default: #)

*see https://networkupstools.org/stable-hcl.html for compatibility list