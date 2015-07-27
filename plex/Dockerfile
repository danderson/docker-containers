FROM ubuntu
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install wget cifs-utils && \
    wget -O plex.deb https://downloads.plex.tv/plex-media-server/0.9.12.4.1192-9a47d21/plexmediaserver_0.9.12.4.1192-9a47d21_amd64.deb && \
    dpkg -i plex.deb && \
    apt-get -y purge wget && \
    apt-get -y autoremove --purge && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm plex.deb
