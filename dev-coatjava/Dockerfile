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
COPY bos2evio $COATJAVA/bin/
WORKDIR /root/
#ENTRYPOINT ["/bin/zsh"]
