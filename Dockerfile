from golang:1.6.0
#ENV GO15VENDOREXPERIMENT=1
# Install RocksDB
RUN cd /opt  && git clone --branch v4.1 --single-branch --depth 1 https://github.com/facebook/rocksdb.git && cd rocksdb && make shared_lib
ENV LD_LIBRARY_PATH=/opt/rocksdb:$LD_LIBRARY_PATH
RUN apt-get update && apt-get install -y libsnappy-dev zlib1g-dev libbz2-dev


WORKDIR /
RUN apt-get install haproxy -y
COPY haproxy.cfg /etc/haproxy/haproxy.cfg

# Copy GOPATH src and install Peer
RUN mkdir -p /var/openchain/db
WORKDIR $GOPATH/src/github.com/hyperledger/fabric/
COPY . .
WORKDIR membersrvc
RUN pwd
RUN CGO_CFLAGS="-I/opt/rocksdb/include" CGO_LDFLAGS="-L/opt/rocksdb -lrocksdb -lstdc++ -lm -lz -lbz2 -lsnappy" go install

RUN cp ../start.sh $GOPATH/bin
RUN chmod +x $GOPATH/bin/start.sh
