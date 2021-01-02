# nut-docker

**NUT-SERVER**

This is a simple debian image with the nut-server package installed.


**USAGE**

Just run the image publishing the port and pointing to the ups device path. Use lsusb to find the current Bus and Device

docker run -d -p 3493:3493 --name=Nut --restart unless-stopped --device=/dev/bus/usb/001/005 nardo86/nut-server 

**EXTRA OPTIONS**

Environment variable used for the configuration

**NAME**		a simple name for your ups 	(default: myups)

**DRIVER**		the driver to use*			(default: usbhid-ups)

**PORT**		device port 					(default: auto)

**POLLFREQ**	polling Interval 				(default: 5)

**DESC**		full description for your ups  	(default: UPS)

*see https://networkupstools.org/stable-hcl.html for compatibility list