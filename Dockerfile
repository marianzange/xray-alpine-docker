FROM alpine:3.7

LABEL maintainer="Marian Zange <marian@crashpad.io>"

RUN apk add --no-cache libc6-compat curl unzip ca-certificates 
RUN apk add --no-cache curl unzip && \
  mkdir workspace && \
  curl -Lsf https://s3.dualstack.us-east-1.amazonaws.com/aws-xray-assets.us-east-1/xray-daemon/aws-xray-daemon-linux-2.x.zip -o install.zip && \
  unzip ./install.zip && \
  mv xray /usr/bin/xray && \
  rm -rf workspace && \
  apk del curl unzip

ENTRYPOINT ["xray"]

CMD ["--bind=0.0.0.0:2000", "--region=us-east-1"]
