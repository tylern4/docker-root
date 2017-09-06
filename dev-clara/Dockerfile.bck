FROM tylern4/dev-env:latest

RUN apt-get -y update && apt-get -y upgrade \
    && apt-get -y install libzmq3-dev libprotobuf-dev protobuf-compiler 

RUN cd /tmp/ && git clone https://github.com/JeffersonLab/xmsg-cpp.git \
    && cd /tmp/xmsg-cpp \ 
    && ./configure --prefix=/usr/local/ \
    && make -j$(nproc) \
    && make install \
    && rm -rf /tmp/xmsg-cpp

RUN cd /tmp/ && git clone https://github.com/JeffersonLab/clara-cpp.git \
    && cd /tmp/clara-cpp \
    && ./configure --prefix=/usr/local/ \
    && make -j$(nproc) \
    && make install \
    && rm -rf /tmp/clara-cpp

WORKDIR /root/

EXPOSE 22
ENTRYPOINT ["/bin/zsh"]
