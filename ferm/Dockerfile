FROM alpine
RUN apk -U add ferm && rm -rf /var/cache/apk/*
ENV \
  FERM_IN=/etc/ferm/ferm.conf \
  FERM_OUT=/etc/ferm/ferm.rules
CMD ferm --remote $FERM_IN >$FERM_OUT
