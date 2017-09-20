FROM centos:7
ENV TERM xterm

ENV ROOTSYS /usr/local/root
ENV PATH $ROOTSYS/bin:$PATH
ENV PYTHONDIR $PYTHONDIR:$ROOTSYS
ENV LD_LIBRARY_PATH $ROOTSYS/lib:$PYTHONDIR/lib:$ROOTSYS/bindings/pyroot:$LD_LIBRARY_PATH
ENV DYLD_LIBRARY_PATH /usr/lib:$ROOTSYS/lib:$PYTHONDIR/lib:$ROOTSYS/bindings/pyroot:$DYLD_LIBRARY_PATH
ENV PYTHONPATH $PYTHONPATH:$ROOTSYS/lib:$ROOTSYS/bindings/pyroot

RUN yum -y install epel-release && yum -y update \
    && yum install -y perl git cmake3 gcc-c++ gcc binutils bash \
    make libX11-devel libXpm-devel libXft-devel libXext-devel xbae-devel libXaw-devel \
    subversion scons patch expat-devel mysql-devel bzip2-devel \
    blas-devel blas-static lapack-devel lapack-static bzip2 tcsh \
    sqlite-devel gcc-gfortran openssl-devel pcre-devel \
    mesa-libGL-devel mesa-libGLU-devel glew-devel ftgl-devel \
    fftw-devel cfitsio-devel graphviz-devel \
    avahi-compat-libdns_sd-devel libldap-dev python-devel \
    libxml2-devel gsl-static xz tar file scons openmotif-devel \
    wget libXmu-devel libXp-devel libXt-devel libjpeg-devel libpng-devel \
    tcl tcl-devel tk tk-devel imake libtool lz4 lz4-devel python-pip zsh \
    && yum clean all \
    && ln -s /usr/bin/gfortran /usr/bin/g77 \
    && ln -s /usr/lib64/liblapack.a /usr/lib64/liblapack3.a


ENV PYTHIA /usr/local/pythia
ENV PYTHIA6 $PYTHIA/pythia6
ENV PYTHIA8 $PYTHIA/pythia8
ENV PYTHIA8DATA /usr/local/pythia/pythia8/xmldoc
ENV PYTHIAVERSION pythia82
RUN mkdir $PYTHIA

RUN cd /tmp/ \
    && wget http://www.hepforge.org/archive/pythia6/pythia-6.4.28.f.gz \
    && wget https://root.cern.ch/download/pythia6.tar.gz \
    && tar -xvf pythia6.tar.gz \
    && gunzip pythia-6.4.28.f.gz \
    && mv pythia-6.4.28.f pythia6/pythia6416.f \
    && cd pythia6 \
    && ./makePythia6.linux \
    && cd .. \
    && mv pythia6 $PYTHIA \
    && rm pythia6.tar.gz

RUN cd /tmp/ \
    && git clone https://github.com/root-project/root.git

RUN ln -s /usr/bin/cmake3 /usr/bin/cmake
RUN cd /tmp/root \
    && mkdir compile \
    && cd compile \
    && cmake -Dfortran=ON -Dpython=ON -Dcxx11=ON -Droofit=ON \
    -DCMAKE_INSTALL_PREFIX:PATH=/usr/local/root .. | tee /root/config.txt \
    && make -j$(nproc) | tee /root/build.txt && make && make install \
    && rm -rf /tmp/root


RUN cd /tmp/ \
    && wget http://home.thep.lu.se/~torbjorn/pythia8/$PYTHIAVERSION.tgz \
    && tar -xvf $PYTHIAVERSION.tgz \
    && cd $PYTHIAVERSION \
    && ./configure --enable-shared \
    --with-python --with-python-include=/usr/include/python2.7 \
    --with-root --with-root-include=/usr/local/root/include --prefix=$PYTHIA8\
    && make -j$(nproc) \
    && cd .. \
    && rm -rf *

ENTRYPOINT ["root.exe","-qb" ]
#cd $ROOTSYS && source bin/thisroot.sh && cd && root -b
