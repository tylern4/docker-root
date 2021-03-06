FROM centos:7
LABEL maintainer "tylern@jlab.org"
ENV TERM xterm

ENV ROOTSYS /usr/local/root
ENV PATH $ROOTSYS/bin:$PATH
ENV PYTHONDIR $PYTHONDIR:$ROOTSYS
ENV LD_LIBRARY_PATH $ROOTSYS/lib:$PYTHONDIR/lib:$ROOTSYS/bindings/pyroot:$LD_LIBRARY_PATH
ENV DYLD_LIBRARY_PATH /usr/lib:$ROOTSYS/lib:$PYTHONDIR/lib:$ROOTSYS/bindings/pyroot:$DYLD_LIBRARY_PATH
ENV PYTHONPATH $PYTHONPATH:$ROOTSYS/lib:$ROOTSYS/bindings/pyroot

RUN yum -y install epel-release  && yum -y install centos-release-scl \
    && yum install -y devtoolset-7-gcc* && scl enable devtoolset-7 sh \
    && yum -y update \
    && yum install -y perl git cmake cmake3 gcc-c++ gcc binutils bash parallel \
    make libX11-devel libXpm-devel libXft-devel libXext-devel xbae-devel libXaw-devel \
    subversion scons patch expat-devel mysql-devel bzip2-devel \
    blas-devel blas-static lapack-devel lapack-static bzip2 tcsh \
    sqlite-devel gcc-gfortran openssl-devel pcre-devel \
    mesa-libGL-devel mesa-libGLU-devel glew-devel ftgl-devel \
    fftw-devel cfitsio-devel graphviz-devel which mv \
    avahi-compat-libdns_sd-devel libldap-dev python-devel \
    libxml2-devel gsl-static xz tar file scons openmotif-devel \
    wget libXmu-devel libXp-devel libXt-devel libjpeg-devel libpng-devel \
    tcl tcl-devel tk tk-devel imake libtool openmpi openmpi-devel \
    python-pip python-wheel python3-pip python3 python3-wheel parallel \
    && gcc --version \
    && yum clean all && rm -rf /var/cache/yum

WORKDIR /tmp/

ENV ROOT_VER v6-20-06

RUN wget --quiet https://github.com/root-project/root/archive/$ROOT_VER.tar.gz \
    && tar -xf $ROOT_VER.tar.gz \
    && rm -rf $ROOT_VER.tar.gz \
    && cd /tmp/root* \
    && mkdir compile \
    && cd compile \
    && cmake3 \
    -DCMAKE_INSTALL_PREFIX:PATH=/usr/local/root \
    -Dcxx11=ON -Dpython=ON -Droot7=OFF -Droofit=ON .. \
    && make -j$(nproc) && make && make install \
    && rm -rf /tmp/*

COPY root-entrypoint.sh /usr/local/sbin

ENTRYPOINT ["/usr/local/sbin/root-entrypoint.sh"]
