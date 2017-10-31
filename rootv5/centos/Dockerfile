FROM centos:6.6
LABEL maintainer "tylern@jlab.org"
ENV TERM xterm

ENV ROOTSYS /usr/local/root
ENV PATH $ROOTSYS/bin:$PATH
ENV PYTHONDIR $PYTHONDIR:$ROOTSYS
ENV LD_LIBRARY_PATH $ROOTSYS/lib:$PYTHONDIR/lib:$ROOTSYS/bindings/pyroot:$LD_LIBRARY_PATH
ENV DYLD_LIBRARY_PATH /usr/lib:$ROOTSYS/lib:$PYTHONDIR/lib:$ROOTSYS/bindings/pyroot:$DYLD_LIBRARY_PATH
ENV PYTHONPATH $PYTHONPATH:$ROOTSYS/lib:$ROOTSYS/bindings/pyroot

RUN yum -y install epel-release && yum -y update \
    && yum install -y perl git cmake gcc-c++ gcc binutils bash parallel \
    make libX11-devel libXpm-devel libXft-devel libXext-devel xbae-devel libXaw-devel \
    subversion scons patch expat-devel mysql-devel bzip2-devel \
    blas-devel blas-static lapack-devel lapack-static bzip2 tcsh \
    sqlite-devel gcc-gfortran openssl-devel pcre-devel \
    mesa-libGL-devel mesa-libGLU-devel glew-devel ftgl-devel \
    fftw-devel cfitsio-devel graphviz-devel which mv \
    avahi-compat-libdns_sd-devel libldap-dev python-devel \
    libxml2-devel gsl-static xz tar file scons openmotif-devel \
    wget libXmu-devel libXp-devel libXt-devel libjpeg-devel libpng-devel \
    tcl tcl-devel tk tk-devel imake libtool mlocate \
    && yum clean all \
    && ln -s /usr/lib64/liblapack.a /usr/lib64/liblapack3.a

RUN cd /tmp/ \
    && wget https://github.com/root-project/root/archive/v5-34-36.tar.gz \
    && tar -xvf v5-34-36.tar.gz \
    && rm -f v5-34-36.tar.gz \
  	&& cd root-5-34-36/ \
  	&& ./configure --all --prefix=$ROOTSYS \
  	&& make -j$(nproc) && make && make install \
    && rm -rf /tmp/*

RUN cd /tmp/ \
    && wget http://ftp.gnu.org/gnu/parallel/parallel-latest.tar.bz2 \
    && tar -xvf parallel-latest.tar.bz2 \
    && rm -rf parallel-latest.tar.bz2 \
    && cd parallel-* \
    && ./configure \
    && make && make install \
    && cp src/parallel /usr/local/bin/ \
    && rm -rf /tmp/*

COPY root-entrypoint.sh /usr/local/sbin

ENTRYPOINT ["/usr/local/sbin/root-entrypoint.sh"]
