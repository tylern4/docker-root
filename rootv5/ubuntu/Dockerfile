FROM ubuntu:latest
LABEL maintainer "tylern@jlab.org"
ENV TERM xterm

ENV ROOTSYS /usr/local/root
ENV PATH $ROOTSYS/bin:$PATH
ENV PYTHONDIR $PYTHONDIR:$ROOTSYS
ENV LD_LIBRARY_PATH $ROOTSYS/lib:$PYTHONDIR/lib:$ROOTSYS/bindings/pyroot:$LD_LIBRARY_PATH
ENV DYLD_LIBRARY_PATH /usr/lib:$ROOTSYS/lib:$PYTHONDIR/lib:$ROOTSYS/bindings/pyroot:$DYLD_LIBRARY_PATH
ENV PYTHONPATH $PYTHONPATH:$ROOTSYS/lib:$ROOTSYS/bindings/pyroot

RUN apt-get -y update && apt-get -y upgrade \
    && apt-get -y install apt-utils zsh perl git dpkg-dev cmake g++ gcc \
    binutils libx11-dev libxpm-dev x11-common libx11-6 x11-utils \
    libgsl0-dev gsl-bin libxft-dev \
    libjpeg-turbo8-dev libjpeg8-dev libjpeg8-dev libjpeg-dev \
    libxml2-dev libssl-dev libgnutls-dev libgmp3-dev \
    libpng12-dev libldap2-dev libkrb5-dev freeglut3-dev libfftw3-dev \
    libmysqlclient-dev libgif-dev libiodbc2 libiodbc2-dev \
    subversion libxmu-dev libimlib2 gccxml \
    libxft-dev libxext-dev gfortran libssl-dev libpcre3-dev \
    xlibmesa-glu-dev libglew1.5-dev libftgl-dev \
    libmysqlclient-dev libfftw3-dev libcfitsio-dev \
    graphviz-dev libavahi-compat-libdnssd-dev \
    libldap2-dev python-dev python3 python3-dev libxml2-dev libkrb5-dev \
    libgsl0-dev libqt4-dev python-pip python3-pip wget curl python-tk \
    texlive-xetex texlive-latex-base \
    && apt-get clean

RUN cd /tmp/ \
    && wget --quiet https://github.com/root-project/root/archive/v5-34-36.tar.gz \
    && tar -xvf v5-34-36.tar.gz \
    && rm -f v5-34-36.tar.gz \
  	&& cd root-5-34-36/ \
  	&& ./configure linuxx8664gcc --all --prefix=$ROOTSYS \
  	&& make -j$(nproc) && make && make install \
  	&& source bin/thisroot.sh

RUN cd /tmp/ \
    && wget --quiet http://ftp.gnu.org/gnu/parallel/parallel-latest.tar.bz2 \
    && tar -xvf parallel-latest.tar.bz2 \
    && rm -rf parallel-latest.tar.bz2 \
    && cd parallel-* \
    && ./configure \
    && make && make install \
    && cp src/parallel /usr/local/bin/

COPY root-entrypoint.sh /usr/local/sbin

ENTRYPOINT ["/usr/local/sbin/root-entrypoint.sh"]
