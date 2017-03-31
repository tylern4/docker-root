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
    tcl tcl-devel tk tk-devel imake libtool \
    && yum clean all \
    && ln -s /usr/lib64/liblapack.a /usr/lib64/liblapack3.a

RUN cd /tmp/ \
  && git clone https://github.com/root-project/root.git \
  && cd root \
  && mkdir compile \
  && cd compile \
  && cmake3 -Dfortran=ON -Dpython=ON -Dcxx11=ON -Droofit=ON -DCMAKE_INSTALL_PREFIX:PATH=/usr/local/root .. \
  && make -j$(nproc) && make && make install \
  && rm -rf /tmp/root

EXPOSE 22
ENTRYPOINT cd $ROOTSYS && source bin/thisroot.sh && cd && root -b
