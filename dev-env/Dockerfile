FROM ubuntu:16.04
ENV TERM xterm

COPY zshrc /root/.zshrc
copy oh-my-zsh /root/.oh-my-zsh

ENV ROOTSYS /usr/local/root
ENV PATH $ROOTSYS/bin:$PATH
ENV PYTHONDIR $PYTHONDIR:$ROOTSYS
ENV LD_LIBRARY_PATH $ROOTSYS/lib:$PYTHONDIR/lib:$ROOTSYS/bindings/pyroot:$LD_LIBRARY_PATH
ENV DYLD_LIBRARY_PATH /usr/lib:$ROOTSYS/lib:$PYTHONDIR/lib:$ROOTSYS/bindings/pyroot:$DYLD_LIBRARY_PATH
ENV PYTHONPATH $PYTHONPATH:$ROOTSYS/lib:$ROOTSYS/bindings/pyroot

RUN apt-get -y update && apt-get -y upgrade \
    && apt-get -y install zsh perl git dpkg-dev cmake g++ gcc \
    binutils libx11-dev libxpm-dev \
    libxft-dev libxext-dev gfortran libssl-dev libpcre3-dev \
    xlibmesa-glu-dev libglew1.5-dev libftgl-dev \
    libmysqlclient-dev libfftw3-dev libcfitsio-dev \
    graphviz-dev libavahi-compat-libdnssd-dev \
    libldap2-dev python-dev libxml2-dev libkrb5-dev \
    libgsl0-dev libqt4-dev python-pip

RUN cd /tmp/ \
    && git clone -b v6-06-00-patches https://github.com/root-project/root.git

RUN cd /tmp/root/ \
    && mkdir compile \
    && cd compile \
    && cmake -Dfortran=ON -Dpython=ON -Dcxx11=ON -Droofit=ON -DCMAKE_CXX_FLAGS=-D_GLIBCXX_USE_CXX11_ABI=0 -DCMAKE_INSTALL_PREFIX:PATH=/usr/local/root .. \
    && make -j$(nproc) && make && make install && rm -rf /tmp/root

RUN pip install --upgrade pip \
    && pip install jupyter scikit-learn numpy matplotlib dill

RUN ROOTSYS=$ROOTSYS pip install root-numpy

WORKDIR /root/

EXPOSE 22
ENTRYPOINT ["/bin/zsh"]
