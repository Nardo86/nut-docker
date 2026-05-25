# NUT Server Docker Container

Containerized [Network UPS Tools](https://networkupstools.org/) server on Debian,
for monitoring USB UPS devices over the network (port 3493). Multi-arch:
`linux/amd64`, `linux/arm64`, `linux/arm/v7`. Tested on Raspberry Pi 4.

> **Status:** community-maintained, no active testing. Functional and stable
> for the author's setup (Raspberry Pi 4 + APC USB UPS). Issues and PRs welcome.

## Quick Start

```yaml
services:
  nut-server:
    image: nardo86/nut-server:latest
    container_name: nut-server
    ports:
      - "3493:3493"
    devices:
      - "/dev/bus/usb/001/005:/dev/bus/usb/001/005"  # see "Find your UPS" below
    environment:
      NAME: home-ups
      DESC: Home APC Back-UPS ES 700
      POLLFREQ: 5
      TZ: Europe/Rome
    restart: unless-stopped
```

Or as a one-shot `docker run`:

```bash
docker run -d --name nut-server -p 3493:3493 \
  --device=/dev/bus/usb/001/005 \
  --restart unless-stopped \
  nardo86/nut-server:latest
```

## Configuration

| Variable      | Description                  | Default      |
|---------------|------------------------------|--------------|
| `NAME`        | UPS identifier               | `ups`        |
| `DRIVER`      | NUT driver                   | `usbhid-ups` |
| `PORT`        | Device port                  | `auto`       |
| `POLLFREQ`    | Polling interval (s)         | `5`          |
| `DESC`        | UPS description              | `UPS`        |
| `USERSSTRING` | NUT users block (see below)  | `#` (none)   |
| `TZ`          | Timezone                     | `Etc/UTC`    |

### Find your UPS

```bash
lsusb
# Bus 001 Device 005: ID 051d:0002 American Power Conversion UPS
#     ^^^        ^^^
# → --device=/dev/bus/usb/001/005
```

### Synology / remote monitoring users

```bash
USERSSTRING='[monuser]
  password = secret
  upsmon slave'
```

Compatible drivers: see the [NUT Hardware Compatibility List](https://networkupstools.org/stable-hcl.html).
Common alternatives to `usbhid-ups`: `blazer_usb`, `nutdrv_qx`.

## Troubleshooting

- **Device not found:** check `lsusb` on the host, verify the `--device` path,
  ensure the container has access (no `--user` overrides, USB cgroup allowed).
- **Connection refused on 3493:** verify port mapping and host firewall.
- **Driver errors in logs:** wrong driver for your model — try `blazer_usb` or
  `nutdrv_qx`.

## Notes

- **NUT version** tracks whatever Debian stable ships (currently bookworm),
  not the upstream latest.
- **Built with help from Claude (Anthropic).** Review the configuration before
  production use. No warranty.
- Image: <https://hub.docker.com/r/nardo86/nut-server>

## Support

⭐ Star • 🐛 Issue • 🔧 PR • ☕ <https://paypal.me/ErosNardi>
