FROM debian:jessie
MAINTAINER Heiner Peuser <heiner.peuser@weweave.net>

RUN apt-get update && \
    apt-get install -y apt-transport-https wget && \
    wget https://homegear.eu/packages/Release.key && apt-key add Release.key && rm Release.key && \
    echo 'deb https://homegear.eu/packages/Debian/ jessie/' >> /etc/apt/sources.list.d/homegear.list && \
    apt-get update && \
    apt-get -y install homegear homegear-homematicbidcos homegear-homematicwired homegear-insteon homegear-max homegear-philipshue homegear-sonos homegear-kodi homegear-ipcam homegear-beckhoff homegear-knx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cd /bin && \
    wget https://github.com/ohjames/smell-baron/releases/download/v0.4.1/smell-baron && \
    chmod a+x smell-baron

ADD run-homegear.sh /bin/run-homegear.sh
RUN chmod a+x /bin/run-homegear.sh

EXPOSE 2001 2002 2003

ENTRYPOINT ["/bin/smell-baron"]
CMD ["/bin/run-homegear.sh"]