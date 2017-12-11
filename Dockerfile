FROM centos:7
LABEL MAINTAINER="Petr Kotas <pkotas@redhat.com>"

ENV GOVERSION 1.9.2
ENV GOVERSIONSHA de874549d9a8d8d8062be05808509c09a88a248e77ec14eb77453530829ac02b
ENV GOFILE go$GOVERSION.linux-amd64.tar.gz
ENV GOURL https://redirector.gvt1.com/edgedl/go/$GOFILE

RUN mkdir -p /usr/local/go
ENV GOPATH /usr/local/go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN set -eux &&\
    yum -y update &&\
    yum -y install git which &&\
    yum -y clean all &&\
    curl -OL $GOURL &&\
    echo "$GOVERSIONSHA $GOFILE" | sha256sum -c - &&\
    tar -C /usr/local -xzf $GOFILE &&\
    rm $GOFILE &&\
    mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH" &&\
    curl https://glide.sh/get | sh

WORKDIR ${GOPATH}
