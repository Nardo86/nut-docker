# NUT Server Docker Container

A lightweight containerized Network UPS Tools (NUT) server built on Debian, designed for monitoring and managing UPS devices across your network infrastructure.

## ⚠️ Project Status

This project is **community-maintained** and no more tested. While functional and stable:

- **Multi-Architecture**: Supports ARM32, ARM64, and AMD64 platforms
- **Updates**: Automated builds ensure latest NUT server versions
- **Support**: Community-based support via GitHub issues

## Features

- 🔌 **USB UPS Support** - Direct USB device connectivity for most UPS models
- 🌐 **Network Monitoring** - NUT server accessible across your network (port 3493)
- 🔧 **Easy Configuration** - Environment variable based setup
- 🏠 **Home Server Ready** - Perfect for Raspberry Pi, home labs, and NAS systems
- 📱 **Client Compatible** - Works with Synology NAS, HomeAssistant, and other NUT clients
- 🐳 **Multi-Architecture** - Native support for ARM32, ARM64, and AMD64

## Quick Start

### Basic Usage
```bash
docker run -d \
  --name=nut-server \
  -p 3493:3493 \
  --device=/dev/bus/usb/001/005 \
  --restart unless-stopped \
  nardo86/nut-server
```

### With Custom Configuration
```bash
docker run -d \
  --name=nut-server \
  -p 3493:3493 \
  --device=/dev/bus/usb/001/005 \
  -e NAME="office-ups" \
  -e DESC="Office APC UPS" \
  -e POLLFREQ=10 \
  --restart unless-stopped \
  nardo86/nut-server
```

### Docker Compose
```yaml
version: '3.8'
services:
  nut-server:
    image: nardo86/nut-server
    container_name: nut-server
    ports:
      - "3493:3493"
    devices:
      - "/dev/bus/usb/001/005:/dev/bus/usb/001/005"
    environment:
      - NAME=home-ups
      - DESC=Home APC Back-UPS ES 700
      - POLLFREQ=5
      - TZ=Europe/Rome
    restart: unless-stopped
```

## Configuration

### Environment Variables

| Variable | Description | Default | Example |
|----------|-------------|---------|---------|
| `NAME` | UPS identifier name | `ups` | `office-ups` |
| `DRIVER` | UPS driver to use | `usbhid-ups` | `blazer_usb` |
| `PORT` | Device port/path | `auto` | `/dev/ttyUSB0` |
| `POLLFREQ` | Polling interval (seconds) | `5` | `10` |
| `DESC` | UPS description | `UPS` | `Office APC UPS` |
| `USERSSTRING` | User configuration | `#` | See below |
| `TZ` | Timezone | `Etc/UTC` | `Europe/Rome` |

### Finding Your UPS Device

Use `lsusb` to identify your UPS device:
```bash
lsusb
# Output: Bus 001 Device 005: ID 051d:0002 American Power Conversion UPS
# Use: --device=/dev/bus/usb/001/005
```

### User Configuration

For Synology NAS compatibility:
```bash
-e USERSSTRING='[monuser]
  password = secret
  upsmon slave'
```

## Supported UPS Models

This container supports most USB UPS devices. Check the [NUT Hardware Compatibility List](https://networkupstools.org/stable-hcl.html) for your specific model.

## Troubleshooting

### Device Not Found
- Verify UPS is connected via USB
- Check device path with `lsusb`
- Ensure container has device access permissions

### Connection Issues
- Verify port 3493 is accessible
- Check firewall settings
- Ensure NUT client configuration matches server settings

### Driver Issues
- Check [NUT compatibility list](https://networkupstools.org/stable-hcl.html)
- Try different drivers (e.g., `blazer_usb`, `nutdrv_qx`)
- Monitor container logs for error messages

## Image Repository

Available at: https://hub.docker.com/r/nardo86/nut-server

## ⚠️ AI Disclaimer

This project was developed with the assistance of Claude AI (Anthropic). While functional, please be aware that:

- **Security considerations**: The configuration may not be optimized for production environments
- **Best practices**: Some settings might not follow enterprise-grade security standards  
- **Testing required**: Thoroughly test in your environment before production use
- **No warranty**: Use at your own risk - review all configurations before deployment
- **Community input welcome**: Issues and improvements are encouraged via GitHub issues/PRs

**Recommendation**: Have a security professional review the setup before production deployment.

## Support & Donations

This is a community project maintained on a volunteer basis. 

**If this project helped you:**
- ⭐ Star the repository on GitHub
- 🐛 Report issues and bugs
- 🔧 Contribute improvements
- ☕ Feel free to consider donating if my work helped you! https://paypal.me/ErosNardi

**For issues:**
1. Check existing GitHub issues
2. Review security considerations
3. Test in isolated environment
4. Provide detailed reproduction steps including UPS model
5. Be patient - this is maintained on volunteer basis

## Version Information

- **Base Image**: Debian Bullseye Slim
- **NUT Version**: Latest available from Debian repositories
- **Architectures**: ARM32, ARM64, AMD64
- **Update Schedule**: Automated monthly builds
