FROM cern/cc7-base:latest
ENV TERM xterm

RUN yum -y update && yum install -y java-1.8.0-openjdk \
    gcc-c++ gcc libX11-devel mesa-libGLU-devel expat-devel zlib-devel \
    scons mysql-devel wget tcsh git cmake3 make bc vim emacs nano file \
    qt-devel perl binutils bash parallel \
    libX11-devel libXpm-devel libXft-devel libXext-devel xbae-devel libXaw-devel \
    subversion scons patch expat-devel mysql-devel bzip2-devel \
    blas-devel blas-static lapack-devel lapack-static bzip2 tcsh \
    sqlite-devel gcc-gfortran openssl-devel pcre-devel \
    mesa-libGL-devel mesa-libGLU-devel glew-devel ftgl-devel \
    fftw-devel cfitsio-devel graphviz-devel \
    avahi-compat-libdns_sd-devel libldap-dev python-devel \
    libxml2-devel gsl-static xz tar file scons openmotif-devel \
    wget libXmu-devel libXp-devel libXt-devel libjpeg-devel libpng-devel \
    tcl tcl-devel tk tk-devel imake libtool qt5-qtbase

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

WORKDIR /tmp/
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

## CLHEP
RUN wget $BASE_URL/clhep/clhep-$CLHEP_VERSION.tgz \
    && tar -zxpvf clhep-$CLHEP_VERSION.tgz \
    && cd $CLHEP_VERSION \
    && rm -rf build && mkdir build && cd build \
    && cmake3 -DCMAKE_INSTALL_PREFIX=$CLHEP_BASE_DIR ../CLHEP \
    && make -j$(nproc) \
    && make install \
    && rm -rf /tmp/*

## XERCESC
RUN wget $BASE_URL/xercesc/xerces-c-$XERCESC_VERSION.tar.gz \
    && tar -zxpvf xerces-c-$XERCESC_VERSION.tar.gz \
    && cd xerces-c-$XERCESC_VERSION \
    && ./configure -prefix=$XERCESCROOT \
    && make -j$(nproc) \
    && make install \
    && rm -rf /tmp/*

## geant4
RUN wget $BASE_URL/geant4/geant$GEANT4_VERSION.tar.gz \
    && tar -zxpvf geant$GEANT4_VERSION.tar.gz \
    && cd geant$GEANT4_VERSION \
    && rm -rf build && mkdir build && cd build \
    && cmake3 -DCMAKE_INSTALL_PREFIX=$G4INSTALL \
                  -DGEANT4_INSTALL_DATA=ON \
  								-DGEANT4_USE_GDML=ON \
  								-DXERCESC_ROOT_DIR=$XERCESCROOT \
  								-DGEANT4_USE_QT=ON \
  								-DQT_QMAKE_EXECUTABLE=$QTDIR/bin/qmake \
  								-DCMAKE_INSTALL_DATAROOTDIR=$G4INSTALL/data \
  								-DCLHEP_ROOT_DIR=$CLHEP_BASE_DIR \
  								-DGEANT4_INSTALL_DATA=$DATA \
  								-DGEANT4_BUILD_EXAMPLES=OFF \
                  -DGEANT4_USE_OPENGL_X11=ON \
  								-DCMAKE_CXX_FLAGS=-I$QTDIR/include \
                  -I$QTDIR/include/QtOpenGL \
                  -I$QTDIR/include/QtWidgets \
                  -I$QTDIR/include/QtGui \
                  -I$QTDIR/include/QtCore \
                  -I$QTDIR/include/QtPrintSupport \
                  "-W -Wall -pedantic -Wno-non-virtual-dtor -Wno-long-long -Wwrite-strings -Wpointer-arith -Woverloaded-virtual -pipe" \
                  ..

## scons
RUN rm -rf $JLAB_ROOT/$JLAB_VERSION/scons_bm/$SCONS_BM_VERSION \
    && mkdir -p $JLAB_ROOT/$JLAB_VERSION/scons_bm/ \
    && cd $JLAB_ROOT/$JLAB_VERSION/scons_bm/ \
    && wget $BASE_URL/scons_bm/scons_bm-$SCONS_BM_VERSION.tar.gz \
    && tar -zxpvf scons_bm-$SCONS_BM_VERSION.tar.gz \
    && rm -rf scons_bm-$SCONS_BM_VERSION.tar.gz

## EVIO
RUN mkdir -p $JLAB_SOFTWARE/evio && cd $JLAB_SOFTWARE/evio \
    && wget $BASE_URL/evio/evio-$EVIO_VERSION.tar.gz \
    && tar -zxpvf evio-$EVIO_VERSION.tar.gz \
    && rm -rf evio-$EVIO_VERSION.tar.gz \
    && cd $EVIO_VERSION \
    && scons -j$(nproc)

## mysql
RUN mkdir -p $JLAB_SOFTWARE/mysql \
    && ln -sfn /usr/lib64/mysql $JLAB_SOFTWARE/mysql/lib

## CCDB
RUN mkdir -p $JLAB_SOFTWARE/ccdb \
    && cd $JLAB_SOFTWARE/ccdb \
    && wget $BASE_URL/ccdb/ccdb-$CCDB_VERSION.tar.gz \
    && tar -zxpvf ccdb-$CCDB_VERSION.tar.gz \
    && rm -rf ccdb-$CCDB_VERSION.tar.gz \
    && cd ccdb-$CCDB_VERSION \
    && scons -j$(nproc)

## mlibrary
ENV GIT_SSL_NO_VERIFY false
RUN mkdir -p $JLAB_SOFTWARE/mlibrary \
    && wget $BASE_URL/mlibrary/mlibrary-$MLIBRARY_VERSION.tar.gz \
    && tar -zxpvf mlibrary-$MLIBRARY_VERSION.tar.gz \
    && rm -rf mlibrary-$MLIBRARY_VERSION.tar.gz \
    && cd $MLIBRARY_VERSION \
    && scons -j$(nproc) OPT=1 \
    && mkdir cadmeshBuild \
    && cd cadmeshBuild \
    && cmake3 ../cadmesh -DCMAKE_INSTALL_PREFIX:PATH=$MLIBRARY \
    && make -j$(nproc) \
    && make install

## gemc
RUN rm -rf $JLAB_SOFTWARE/gemc/$GEMC_VERSION \
    && mkdir -p $JLAB_SOFTWARE/gemc \
    && cd $JLAB_SOFTWARE/gemc \
    && wget $BASE_URL/gemc/gemc-$GEMC_VERSION.tar.gz \
    && tar -zxpvf gemc-$GEMC_VERSION.tar.gz \
    && rm -rf gemc-$GEMC_VERSION.tar.gz \
    && cd gemc-$GEMC_VERSION \
    && scons -j$(nproc) LIBRARY=shared OPT=1

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

## banks
RUN mkdir -p $JLAB_SOFTWARE/banks \
    && cd $JLAB_SOFTWARE/banks \
    && wget $BASE_URL/banks/banks-$BANKS_VERSION.tar.gz \
    && tar -zxpvf banks-$BANKS_VERSION.tar.gz \
    && rm -rf banks-$BANKS_VERSION.tar.gz \
    && cd $BANKS_VERSION \
    && scons -j$(nproc)

## jana
ENV BMS_OSNAME $OSRELEASE
RUN mkdir -p $JANA_HOME \
    && cd $JLAB_SOFTWARE/jana \
    && wget $BASE_URL/jana/jana_$JANA_VERSION.tgz \
    && tar -zxpvf jana_$JANA_VERSION.tgz \
    && rm -rf jana_$JANA_VERSION.tgz \
    && cd jana_$JANA_VERSION \
    && scons -j$(nproc) install \
    && mv $BMS_OSNAME/* $JANA_HOME \
    && rm -rf $JANA_HOME/src \
    && rm -rf $JLAB_SOFTWARE/jana/$filename \
    && rm -rf $JLAB_SOFTWARE/jana/jana_$JANA_VERSION


## Fields ---Long download---
RUN mkdir -p $JLAB_ROOT/noarch/data \
    && cd $JLAB_ROOT/noarch/data \
    && rm -rf srr* clas12* \
    && wget http://clasweb.jlab.org/12gev/field_maps/clas12SolenoidFieldMap.dat \
    && wget http://clasweb.jlab.org/12gev/field_maps/clas12TorusOriginalMap.dat



ENTRYPOINT ["/bin/bash"]
