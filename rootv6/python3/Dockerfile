FROM python:3.6.4-jessie
LABEL maintainer "tylern@jlab.org"
ENV TERM xterm

ENV ROOTSYS /usr/local/root
ENV PATH $ROOTSYS/bin:$PATH
ENV PYTHONDIR $PYTHONDIR:$ROOTSYS
ENV LD_LIBRARY_PATH $ROOTSYS/lib:$PYTHONDIR/lib:$ROOTSYS/bindings/pyroot:$LD_LIBRARY_PATH
ENV DYLD_LIBRARY_PATH /usr/lib:$ROOTSYS/lib:$PYTHONDIR/lib:$ROOTSYS/bindings/pyroot:$DYLD_LIBRARY_PATH
ENV PYTHONPATH $PYTHONPATH:$ROOTSYS/lib:$ROOTSYS/bindings/pyroot

RUN apt-get -y update && apt-get -y install --reinstall \
    openmpi-bin libopenmpi-dev rsync apt-utils \
    && apt-get -y install zsh scons liblz4-dev \
    git dpkg-dev g++ gcc binutils libx11-dev libxpm-dev \
    libxft-dev libxext-dev gfortran libssl-dev libpcre3-dev \
    xlibmesa-glu-dev libglew1.5-dev libftgl-dev \
    libmysqlclient-dev libfftw3-dev libcfitsio-dev \
    graphviz-dev libavahi-compat-libdnssd-dev \
    libldap2-dev libxml2-dev libkrb5-dev \
    libgsl0-dev libqt4-dev wget libopenmpi-dev xz-utils \
    && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp/
RUN wget --quiet https://cmake.org/files/v3.10/cmake-3.10.1.tar.gz \
    && tar -xvf cmake-3.10.1.tar.gz \
    && cd cmake* \
    && ./bootstrap \
    && make -j$(nproc) \
    && make install \
    && rm -rf /tmp/*


RUN wget --quiet https://github.com/root-project/root/archive/v6-11-02.tar.gz \
    && tar -xf v6-11-02.tar.gz \
    && rm -rf v6-11-02.tar.gz \
    && cd /tmp/root* \
    && mkdir compile \
    && cd compile \
    && cmake \
      -Dall=ON \
      -Droofit=ON \
      -Dpython=ON \
      -DCMAKE_INSTALL_PREFIX:PATH=/usr/local/root .. \
    && make -j$(nproc); make && make install \
    && rm -rf /tmp/*

WORKDIR /root/
COPY root-entrypoint.sh /usr/local/sbin

ENTRYPOINT ["/usr/local/sbin/root-entrypoint.sh"]
