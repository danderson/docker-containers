FROM alpine
RUN apk -U add ferm && rm -rf /var/cache/apk/*
ENV \
  FERM_IN=/etc/ferm/ferm.conf \
  FERM_OUT=/etc/ferm/ferm.rules.sh
CMD ferm --remote --shell $FERM_IN >$FERM_OUT
