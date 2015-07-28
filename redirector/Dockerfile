FROM ubuntu
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install golang && \
    mkdir -p /tmp/redirector
ADD main.go /tmp/redirector/main.go
RUN cd /tmp/redirector && \
    go build . && \
    cp redirector /redirector && \
    apt-get -y remove golang && \
    apt-get -y autoremove --purge && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*
