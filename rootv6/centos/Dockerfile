#tylern4/rootv6:centos7_py3
FROM centos:7
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
    tcl tcl-devel tk tk-devel imake libtool \
    python-pip python-wheel python3-pip python3 python3-wheel \
    && yum clean all

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10

RUN cd /tmp/ \
    && wget http://ftp.gnu.org/gnu/parallel/parallel-latest.tar.bz2 \
    && tar -xvf parallel-latest.tar.bz2 \
    && rm -rf parallel-latest.tar.bz2 \
    && cd parallel-* \
    && ./configure \
    && make && make install \
    && cp src/parallel /usr/local/bin/

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
