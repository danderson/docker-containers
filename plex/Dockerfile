FROM ubuntu
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install wget cifs-utils && \
    wget -O plex.deb https://downloads.plex.tv/plex-media-server/0.9.12.13.1464-4ccd2ca/plexmediaserver_0.9.12.13.1464-4ccd2ca_amd64.deb && \
    dpkg -i plex.deb && \
    apt-get -y purge wget && \
    apt-get -y autoremove --purge && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm plex.deb
