#tylern4/rootv5:centos6
FROM centos:6.9
LABEL maintainer "tylern@jlab.org"
ENV TERM xterm

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
    && wget http://ftp.gnu.org/gnu/parallel/parallel-latest.tar.bz2 \
    && tar -xvf parallel-latest.tar.bz2 \
    && rm -rf parallel-latest.tar.bz2 \
    && cd parallel-* \
    && ./configure \
    && make && make install \
    && cp src/parallel /usr/local/bin/

