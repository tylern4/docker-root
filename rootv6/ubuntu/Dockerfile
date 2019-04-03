FROM ubuntu
LABEL maintainer "tylern@jlab.org"
ENV TERM xterm-256color

ENV ROOTSYS /usr/local/root
ENV PATH $ROOTSYS/bin:$PATH
ENV PYTHONDIR $PYTHONDIR:$ROOTSYS
ENV LD_LIBRARY_PATH $ROOTSYS/lib:$PYTHONDIR/lib:$ROOTSYS/bindings/pyroot:$LD_LIBRARY_PATH
ENV DYLD_LIBRARY_PATH /usr/lib:$ROOTSYS/lib:$PYTHONDIR/lib:$ROOTSYS/bindings/pyroot:$DYLD_LIBRARY_PATH
ENV PYTHONPATH $PYTHONPATH:$ROOTSYS/lib:$ROOTSYS/bindings/pyroot

ENV PYTHIA /usr/local/pythia
ENV PYTHIA8 $PYTHIA/pythia8
ENV PYTHIA8DATA /usr/local/pythia/pythia8/xmldoc
ENV PYTHIAVERSION pythia82
RUN mkdir $PYTHIA

RUN apt-get -y update \
    && apt-get -y install software-properties-common \
    && add-apt-repository -y ppa:ubuntu-toolchain-r/test \
    && apt-get -y update && apt-get -y install --reinstall \
    openmpi-bin libopenmpi-dev apt-utils rsync \
    && apt-get -y install zsh scons liblz4-dev \
    git dpkg-dev cmake g++ gcc binutils libx11-dev libxpm-dev \
    libxft-dev libxext-dev gfortran libssl-dev libpcre3-dev \
    xlibmesa-glu-dev libglew1.5-dev libftgl-dev \
    libmysqlclient-dev libfftw3-dev libcfitsio-dev \
    graphviz-dev libavahi-compat-libdnssd-dev \
    libldap2-dev python-dev libxml2-dev libkrb5-dev python-pip \
    libgsl0-dev libqt4-dev wget xz-utils ccache \
    && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp/
