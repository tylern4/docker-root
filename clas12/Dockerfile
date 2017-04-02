FROM cern/cc7-base:latest
ENV TERM xterm

RUN yum -y update && yum install -y java-1.8.0-openjdk \
    gcc-c++ gcc libX11-devel mesa-libGLU-devel expat-devel zlib-devel \
    scons mysql-devel wget tcsh git cmake3 make bc vim emacs nano file \
    perl binutils bash parallel \
    libX11-devel libXpm-devel libXft-devel libXext-devel xbae-devel libXaw-devel \
    subversion scons patch expat-devel mysql-devel bzip2-devel \
    blas-devel blas-static lapack-devel lapack-static bzip2 tcsh \
    sqlite-devel gcc-gfortran openssl-devel pcre-devel \
    mesa-libGL-devel mesa-libGLU-devel glew-devel ftgl-devel \
    fftw-devel cfitsio-devel graphviz-devel \
    avahi-compat-libdns_sd-devel libldap-dev python-devel \
    libxml2-devel gsl-static xz tar file scons openmotif-devel \
    wget libXmu-devel libXp-devel libXt-devel libjpeg-devel libpng-devel \
    tcl tcl-devel tk tk-devel imake libtool mv

RUN ln -s /usr/bin/cmake3 /usr/bin/cmake

ENV BASE_URL https://www.jlab.org/12gev_phys/packages/sources

ENV OSRELEASE Linux_CentOS7.3.1611-x86_64-gcc4.8.5
ENV JLAB_ROOT /opt/jlab_software
ENV JLAB_VERSION devel
ENV JLAB_SOFTWARE $JLAB_ROOT/$JLAB_VERSION/$OSRELEASE
ENV CLHEP_VERSION 2.3.4.3
ENV CLHEP_BASE_DIR $JLAB_ROOT/$OSRELEASE/clhep/$CLHEP_VERSION
ENV BANKS_VERSION $JLAB_VERSION
ENV BANKS $JLAB_ROOT/$JLAB_VERSION/$OSRELEASE/banks/$JLAB_VERSION
ENV CCDB_VERSION 1.06.02
ENV CCDB_HOME $JLAB_ROOT/$OSRELEASE/ccdb/ccdb-$CCDB_VERSION
ENV CCDB_USER root
ENV EVIO_VERSION 5.1
ENV EVIO $JLAB_ROOT/$JLAB_VERSION/$OSRELEASE/evio/$EVIO_VERSION
ENV GEANT4_VERSION 4.10.02.p03
ENV G4ROOT $JLAB_ROOT/$JLAB_VERSION/$OSRELEASE/geant4
ENV G4INSTALL $JLAB_ROOT/$JLAB_VERSION/$OSRELEASE/geant4/$GEANT4_VERSION
ENV G4DATA_VERSION 10.3.0
ENV G4DATA_DIR $JLAB_ROOT/$JLAB_VERSION/$OSRELEASE/geant4/GEANT4_VERSION/data/Geant4-$G4DATA_VERSION/data
ENV GEMC_VERSION $JLAB_VERSION
ENV GEMC $JLAB_ROOT/$JLAB_VERSION/$OSRELEASE/gemc/$JLAB_VERSION
ENV JANA_VERSION 0.7.7p1
ENV JANA_HOME $JLAB_ROOT/$JLAB_VERSION/$OSRELEASE/jana/$JANA_VERSION
ENV MLIBRARY_VERSION $JLAB_VERSION
ENV MLIBRARY $JLAB_ROOT/$JLAB_VERSION/$OSRELEASE/mlibrary/$JLAB_VERSION
ENV MYSQL $JLAB_ROOT/$JLAB_VERSION/$OSRELEASE/mysql
ENV MYSQINC $JLAB_ROOT/$JLAB_VERSION/$OSRELEASE/mysql/include
ENV MYSQLIB $JLAB_ROOT/$JLAB_VERSION/$OSRELEASE/mysql/lib
ENV MYSQBIN $JLAB_ROOT/$JLAB_VERSION/$OSRELEASE/mysql/bin
ENV MYSQLINC $JLAB_ROOT/$JLAB_VERSION/$OSRELEASE/mysql/include
ENV MYSQL_INCLUDE_PATH $JLAB_ROOT/$JLAB_VERSION/$OSRELEASE/mysql/include
ENV MYSQL_LIB_PATH $JLAB_ROOT/$JLAB_VERSION/$OSRELEASE/mysql/lib
ENV QT_VERSION 5.8.0
ENV QT_BIN_VERSION 5.8
ENV QTSYSTEM gcc_64
ENV QTDIR $JLAB_ROOT/$JLAB_VERSION/$OSRELEASE/qt/$QT_VERSION/$QT_BIN_VERSION/$QTSYSTEM
ENV PKG_CONFIG_PATH $JLAB_ROOT/$JLAB_VERSION/$OSRELEASE/qt/$QT_VERSION/$QT_BIN_VERSION/$QTSYSTEM/lib/pkgconfig
ENV ROOT_VERSION 6.08.04
ENV ROOTSYS $JLAB_ROOT/$JLAB_VERSION/$OSRELEASE/root/$ROOT_VERSION
ENV SCONS_BM_VERSION $JLAB_VERSION
ENV SCONS_BM $JLAB_ROOT/$JLAB_VERSION/scons_bm/$JLAB_VERSION
ENV SCONSFLAGS --site-dir $JLAB_ROOT/$JLAB_VERSION/scons_bm/$JLAB_VERSION
ENV XERCESC_VERSION 3.1.4
ENV XERCESCROOT $JLAB_ROOT/$JLAB_VERSION/$OSRELEASE/xercesc/$XERCESC_VERSION

WORKDIR $JLAB_ROOT

## Fields ---Long download---
RUN mkdir -p $JLAB_ROOT/noarch/data \
    && cd $JLAB_ROOT/noarch/data \
    && rm -rf srr* clas12* \
    && wget http://clasweb.jlab.org/12gev/field_maps/clas12SolenoidFieldMap.dat \
    && wget http://clasweb.jlab.org/12gev/field_maps/clas12TorusOriginalMap.dat

## QT
RUN wget http://download.qt.io/official_releases/qt/5.8/5.8.0/single/qt-everywhere-opensource-src-5.8.0.tar.gz \
    && tar -zxpvf qt-everywhere-opensource-src-5.8.0.tar.gz \
    && rm -rf qt-everywhere-opensource-src-5.8.0.tar.gz \
    && cd qt-everywhere-opensource-src-5.8.0 \
    && ./configure -prefix $QTDIR \
    -skip qtconnectivity \
    -static \
    -release \
    -opensource \
    -confirm-license \
    -nomake examples \
    -nomake tests \
    -no-compile-examples \
    -skip qtgamepad \
    -qt-xcb \
    -fontconfig \
    -v \
    && make -j$(nproc) \
    && make install

## ROOT
RUN wget https://github.com/root-project/root/archive/v6-08-04.tar.gz \
    && tar -zxpvf v6-08-04.tar.gz \
    && rm -rf v6-08-04.tar.gz \
    && cd root-6-08-04 \
    && mkdir compile && cd compile \
    && cmake -DCMAKE_INSTALL_PREFIX=$ROOTSYS \
    -Droofit=ON -Dminuit2=ON -Dpython=ON \
    .. \
    && make -j$(nproc) && make install

## Do rest from install scripts
RUN mkdir -p $JLAB_ROOT/devel \
    && cd $JLAB_ROOT \
    && wget http://www.jlab.org/12gev_phys/packages/sources/ceInstall/ceInstall_devel.tar.gz \
    && tar -zxpvf ceInstall_devel.tar.gz

WORKDIR $JLAB_ROOT/devel/install
RUN ./go_clhep
RUN ./go_xercesc
#RUN ./go_geant4
#RUN ./go_sconsscript
#RUN ./go_evio
#RUN ./go_mysql
#RUN ./go_ccdb
#RUN ./go_mlibrary
#RUN ./go_gemc
#RUN ./go_fields
#RUN ./go_banks
#RUN ./go_jana


ENTRYPOINT ["/bin/bash"]
