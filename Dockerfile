FROM debian:bullseye-slim

# Environment variables with defaults
ENV TZ=Etc/UTC
ENV NAME=ups
ENV DRIVER=usbhid-ups
ENV PORT=auto
ENV POLLFREQ=5
ENV DESC="UPS"
ENV USERSSTRING="#"

# Install NUT server and clean up
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        nut-server \
        tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up basic NUT configuration
RUN sed -i 's/MODE=none/MODE=netserver/g' /etc/nut/nut.conf \
    && echo "LISTEN 0.0.0.0 3493" >> /etc/nut/upsd.conf

# Copy and set entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Create directory for runtime configuration
RUN mkdir -p /var/run/nut && chown nut:nut /var/run/nut

EXPOSE 3493

ENTRYPOINT ["/entrypoint.sh"]
