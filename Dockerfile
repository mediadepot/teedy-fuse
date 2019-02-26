FROM golang:1.8 AS build

WORKDIR /go/src/github.com/mediadepot/teedy-fuse
COPY . .

RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
RUN dep ensure

RUN go build

CMD ["teedy-fuse"]

FROM ubuntu:12.04

RUN apt-get update -qq
RUN apt-get install -y build-essential libfuse-dev fuse-utils libcurl4-openssl-dev libxml2-dev mime-support automake libtool wget tar

COPY --from=build /go/src/github.com/mediadepot/teedy-fuse/teedy-fuse /usr/bin/teedy-fuse
COPY rootfs/ /

ENTRYPOINT "/entrypoint.sh"
