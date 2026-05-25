FROM debian:bookworm-slim

# Environment variables with defaults
ENV TZ=Etc/UTC
ENV NAME=ups
ENV DRIVER=usbhid-ups
ENV PORT=auto
ENV POLLFREQ=5
ENV DESC="UPS"
ENV USERSSTRING="#"

# Install NUT server, configure netserver mode, prepare runtime dirs
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        nut-server \
        nut-client \
        tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && sed -i 's/MODE=none/MODE=netserver/g' /etc/nut/nut.conf \
    && echo "LISTEN 0.0.0.0 3493" >> /etc/nut/upsd.conf \
    && mkdir -p /var/run/nut \
    && chown nut:nut /var/run/nut

COPY --chmod=755 entrypoint.sh /entrypoint.sh

EXPOSE 3493

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD upsc "$NAME@localhost" >/dev/null 2>&1 || exit 1

ENTRYPOINT ["/entrypoint.sh"]
