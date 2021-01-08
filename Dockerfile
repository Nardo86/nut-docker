FROM debian

ENV NAME ups
ENV DRIVER usbhid-ups
ENV PORT auto
ENV POLLFREQ 5
ENV DESC UPS
ENV USERSSTRING #

RUN apt-get update 
RUN apt-get -y install nut-server

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3493
