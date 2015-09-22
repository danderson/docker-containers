FROM alpine

ENV GOPATH=/go GOBIN=/usr/bin

RUN \
  apk -U add go git gcc libc-dev libltdl libtool libgcc &&\
  mkdir -p /go/src &&\
  go get -d github.com/cloudflare/cfssl/... &&\
  go install github.com/cloudflare/cfssl/cmd/cfssl &&\
  go install github.com/cloudflare/cfssl/cmd/cfssljson &&\
  go install github.com/cloudflare/cfssl/cmd/mkbundle &&\
  go install github.com/cloudflare/cfssl/cmd/multirootca &&\
  apk del go git gcc libc-dev libtool libgcc


# RUN apk update && \
#     apk add go git gcc libc-dev libltdl libtool libgcc && \
#     echo "About go get..." && \
#     go get github.com/cloudflare/cf-tls/tls && \
#     go get github.com/cloudflare/go-metrics && \
#     go get github.com/cloudflare/redoctober/core && \
#     go get github.com/dgryski/go-rc2 && \
#     go get golang.org/x/crypto/ocsp && \
#     go get github.com/GeertJohan/go.rice && \
#     go get github.com/miekg/pkcs11 && \
#     echo "About build..." && \
#     (cd cmd/cfssl && go build . ) && \
#     (cd cmd/cfssljson && go build . ) && \
#     (cd cmd/mkbundle && go build . ) && \
#     (cd cmd/multirootca && go build . ) && \
#     echo "About copy binaries..." && \
#     mv cmd/cfssl/cfssl /usr/bin && \
#     mv cmd/cfssljson/cfssljson /usr/bin && \
#     mv cmd/mkbundle/mkbundle  /usr/bin && \
#     mv cmd/multirootca/multirootca  /usr/bin && \
#     echo "Cleaning up..." && \
#     apk del go git gcc libc-dev libtool libgcc && \
#     mv /go/src/github.com/cloudflare/cfssl/cli/serve/static /static && \
#     rm -rf /go && \
#     mkdir -p /go/src/github.com/cloudflare/cfssl/cli/serve && \
#     mv /static /go/src/github.com/cloudflare/cfssl/cli/serve/static && \
#     echo "Build complete."
