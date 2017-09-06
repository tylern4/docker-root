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
    binutils libx11-dev libxpm-dev \
    libxft-dev libxext-dev gfortran libssl-dev libpcre3-dev \
    xlibmesa-glu-dev libglew1.5-dev libftgl-dev \
    libmysqlclient-dev libfftw3-dev libcfitsio-dev \
    graphviz-dev libavahi-compat-libdnssd-dev \
    libldap2-dev python-dev python3 python3-dev libxml2-dev libkrb5-dev \
    libgsl0-dev libqt4-dev python-pip python3-pip wget curl python-tk \
    texlive-xetex texlive-latex-base \
    && apt-get clean

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10

RUN cd /tmp/ \
    && wget --quiet https://github.com/root-project/root/archive/v6-06-08.tar.gz \
    && tar -xvf v6-06-08.tar.gz \
    && rm -rf v6-06-08.tar.gz \
    && cd /tmp/root* \
    && mkdir compile \
    && cd compile \
    && cmake -Dfortran=ON \
        -Dpython=ON \
        -Dcxx11=ON \
        -Droofit=ON \
        -Dpython=ON \
        -DCMAKE_CXX_FLAGS=-D_GLIBCXX_USE_CXX11_ABI=0 \
        -DCMAKE_INSTALL_PREFIX:PATH=/usr/local/root .. \
    && make -j$(nproc) && make && make install \
    && rm -rf /tmp/root

RUN pip install --upgrade pip \
    && pip install jupyter scikit-learn numpy matplotlib

RUN ROOTSYS=$ROOTSYS pip install root-numpy

COPY root-entrypoint.sh /usr/local/sbin

ENTRYPOINT ["/usr/local/sbin/root-entrypoint.sh"]
