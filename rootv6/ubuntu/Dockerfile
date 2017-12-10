FROM ubuntu:latest
LABEL maintainer "tylern@jlab.org"
ENV TERM xterm

ENV ROOTSYS /usr/local/root
ENV PATH $ROOTSYS/bin:$PATH
ENV PYTHONDIR $PYTHONDIR:$ROOTSYS
ENV LD_LIBRARY_PATH $ROOTSYS/lib:$PYTHONDIR/lib:$ROOTSYS/bindings/pyroot:$LD_LIBRARY_PATH
ENV DYLD_LIBRARY_PATH /usr/lib:$ROOTSYS/lib:$PYTHONDIR/lib:$ROOTSYS/bindings/pyroot:$DYLD_LIBRARY_PATH
ENV PYTHONPATH $PYTHONPATH:$ROOTSYS/lib:$ROOTSYS/bindings/pyroot

RUN apt-get -y update && apt-get -y upgrade && apt-get -y install --reinstall \
    openmpi-bin libopenmpi-dev apt-utils \
    && apt-get -y install zsh perl git dpkg-dev cmake g++ gcc \
    binutils libx11-dev libxpm-dev scons liblz4-dev \
    libxft-dev libxext-dev gfortran libssl-dev libpcre3-dev locales \
    xlibmesa-glu-dev libglew1.5-dev libftgl-dev \
    libmysqlclient-dev libfftw3-dev libcfitsio-dev \
    graphviz-dev libavahi-compat-libdnssd-dev \
    libldap2-dev python-dev libxml2-dev libkrb5-dev \
    libgsl0-dev libqt4-dev python-pip wget curl python-tk python3-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR /tmp/
RUN wget --quiet https://github.com/root-project/root/archive/v6-06-08.tar.gz \
    && tar -xvf v6-06-08.tar.gz \
    && rm -rf v6-06-08.tar.gz \
    && cd /tmp/root* \
    && mkdir compile \
    && cd compile \
    && cmake -Dfortran=ON \
        -Dcxx11=ON \
        -Droofit=ON \
        -DCMAKE_CXX_FLAGS=-D_GLIBCXX_USE_CXX11_ABI=0 \
        -DCMAKE_INSTALL_PREFIX:PATH=/usr/local/root .. \
    && make -j$(nproc) && make && make install \
    && rm -rf /tmp/*


ENV PYTHIA /usr/local/pythia
ENV PYTHIA8 $PYTHIA/pythia8
ENV PYTHIA8DATA /usr/local/pythia/pythia8/xmldoc
ENV PYTHIAVERSION pythia82
RUN mkdir $PYTHIA

RUN wget http://home.thep.lu.se/~torbjorn/pythia8/$PYTHIAVERSION.tgz \
    && tar -xvf $PYTHIAVERSION.tgz \
    && cd $(ls -d */ | head -n 1) \
    && ./configure --enable-shared \
    --with-python --with-python-include=/usr/include/python2.7 \
    --with-root --with-root-include=/usr/local/root/include --prefix=$PYTHIA8\
    && make -j$(nproc) && make install \
    && rm -rf /tmp/*

ENV PYTHONPATH $PYTHONPATH:$(ls -d $PYTHIA8/* | head -n 1)/lib
WORKDIR /root/
COPY root-entrypoint.sh /usr/local/sbin

ENTRYPOINT ["/usr/local/sbin/root-entrypoint.sh"]
