FROM tylern4/dev-env

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install scons

WORKDIR /usr/local
RUN git clone https://github.com/gavalian/evioRoot.git
COPY SConstruct /usr/local/evioRoot/SConstruct
RUN cd /usr/local/evioRoot \
    && scons -j$(nproc)

RUN echo "export PATH=$PATH:/usr/local/evioRoot/bin"
