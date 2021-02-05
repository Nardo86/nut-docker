FROM debian:buster-slim

ENV TZ=Etc/UTC
ENV NAME ups
ENV DRIVER usbhid-ups
ENV PORT auto
ENV POLLFREQ 5
ENV DESC UPS
ENV USERSSTRING #

#Installing default packages
RUN echo $TZ > /etc/timezone && apt-get update 
RUN apt-get install -y  nut-server

#Apply configuration
RUN sed -i 's/MODE=none/MODE=netserver/g' /etc/nut/nut.conf \
&& echo "LISTEN 0.0.0.0 3493" >> /etc/nut/upsd.conf \
&& echo -e "[$NAME] \n  driver = $DRIVER \n  port = $PORT \n  pollfreq = $POLLFREQ \n  desc = $DESC" >> /etc/nut/ups.conf \
&& echo -e "$USERSSTRING" >> /etc/nut/upsd.users \
&& chgrp nut /etc/nut/*

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3493
