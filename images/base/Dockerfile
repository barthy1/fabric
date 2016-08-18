FROM ubuntu:trusty
COPY scripts /hyperledger/baseimage/scripts
RUN apt-get update -qq ; apt-get install -y default-jre ; \
	mkdir -p /opt/go ; mkdir -p /opt/gopath ; \
	chmod a+rw -R /opt/gopath 
ENV PATH ${PATH}:/opt/go/bin:/opt/gopath/bin
ENV GOROOT /opt/go
ENV GOPATH /opt/gopath
RUN /hyperledger/baseimage/scripts/common/init.sh
RUN /hyperledger/baseimage/scripts/docker/init.sh
RUN /hyperledger/baseimage/scripts/common/setup.sh
