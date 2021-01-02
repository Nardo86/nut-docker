FROM debian

ENV NAME myups
ENV DRIVER usbhid-ups
ENV PORT auto
ENV POLLFREQ 5
ENV DESC UPS

RUN apt-get update && apt-get -y install nut-server

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3493
