#FROM java:openjdk-8
FROM tylern4/clara-dev:latest
LABEL maintainer "tylern@jlab.org"

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install openjfx

ENV COATJAVA /usr/local/clas12-offline-software/coatjava

WORKDIR /usr/local/
RUN git clone https://github.com/JeffersonLab/clas12-offline-software.git clas12-offline-software
RUN cd clas12-offline-software && git submodule update --init --recursive && git pull

WORKDIR /usr/local/clas12-offline-software

RUN ./build-coatjava.sh

ENV PATH $COATJAVA/bin:$PATH

RUN apt-get install -y scons liblz4-dev

RUN git clone https://github.com/JeffersonLab/jhep.git \
    && cd jhep \
    && rm -rf ~/.m2/repository/org/jlab/jhep \
    && cd jhep-utils ; mvn install; mvn deploy; cd - \
    && cd jhep-cli   ; mvn install; mvn deploy; cd - \
    && cd jhep-hipo  ; mvn install; mvn deploy; cd - \
    && cd jhep-math  ; mvn install; mvn deploy; cd - \
    && cd jhep-hipo/cpp \
    && scons -j$(nproc)

WORKDIR /root/
#ENTRYPOINT ["/bin/zsh"]
