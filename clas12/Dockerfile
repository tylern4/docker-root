FROM ubuntu:16.10
ENV TERM xterm

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
    libgsl0-dev python-pip wget curl python-tk \
    scons libxmu-dev libx11-dev libclhep-dev libxerces-c3-dev \
    freeglut3-dev libmotif-dev tk-dev libxi-dev \
    && apt-get clean

#libqt4-dev qt4-dev-tools

RUN cd /tmp/ \
    && git clone -b v6-06-00-patches https://github.com/root-project/root.git \
    && cd /tmp/root/ \
    && mkdir compile \
    && cd compile \
    && cmake -Dfortran=ON -Dpython=ON -Dcxx11=ON -Droofit=ON -DCMAKE_CXX_FLAGS=-D_GLIBCXX_USE_CXX11_ABI=0 -DCMAKE_INSTALL_PREFIX:PATH=/usr/local/root .. \
    && make -j$(nproc) && make && make install && rm -rf /tmp/root

ENV BASE_URL https://www.jlab.org/12gev_phys/packages/sources

ENV JLAB_ROOT /usr/local/jlab_software
ENV OSRELEASE x86_64
ENV JLAB_VERSION devel
ENV JLAB_SOFTWARE $JLAB_ROOT/$JLAB_VERSION/$OSRELEASE

RUN mkdir -p $JLAB_ROOT/$JLAB_VERSION/install
WORKDIR $JLAB_ROOT/$JLAB_VERSION/install

## Fields ---Long download---
RUN mkdir -p $JLAB_ROOT/noarch/data \
    && cd $JLAB_ROOT/noarch/data \
    && rm -rf srr* clas12* \
    && wget http://clasweb.jlab.org/12gev/field_maps/clas12SolenoidFieldMap.dat \
    && wget http://clasweb.jlab.org/12gev/field_maps/clas12TorusOriginalMap.dat

## QT 5.8
ENV QT_VERSION 5.8.0
ENV QT_BIN_VERSION 5.8
ENV QTSYSTEM gcc_64
ENV QTDIR $JLAB_ROOT/$JLAB_VERSION/install/qt-everywhere-opensource-src-$QT_VERSION
ENV PKG_CONFIG_PATH $QTDIR/lib/pkgconfig

RUN wget http://download.qt.io/official_releases/qt/5.8/$QT_VERSION/single/qt-everywhere-opensource-src-$QT_VERSION.tar.gz \
    && tar -zxpvf qt-everywhere-opensource-src-$QT_VERSION.tar.gz \
    && rm -rf qt-everywhere-opensource-src-$QT_VERSION.tar.gz

RUN cd $QTDIR \
    && ./configure -prefix $QTDIR \
    -skip qtconnectivity \
    #-static \
    -release \
    -opensource \
    -confirm-license \
    -nomake examples \
    -nomake tests \
    -no-compile-examples \
    -skip qtgamepad \
    -v \
    && make -j$(nproc) \
    && make install



## geant4
ENV GEANT4_VERSION 10.03.p01
ENV G4ROOT $JLAB_SOFTWARE/geant4
ENV G4INSTALL $JLAB_SOFTWARE/geant4/$GEANT4_VERSION
ENV G4DATA_VERSION 10.3.0
ENV G4DATA_DIR $JLAB_SOFTWARE/geant4/GEANT4_VERSION/data/Geant4-$G4DATA_VERSION/data

RUN wget http://geant4.web.cern.ch/geant4/support/source/geant4.$GEANT4_VERSION.tar.gz \
    && tar -xvf geant4.$GEANT4_VERSION.tar.gz \
    && rm -rf geant4.$GEANT4_VERSION.tar.gz \
    && cd geant4.$GEANT4_VERSION && mkdir build && cd build \
    && cmake -DCMAKE_INSTALL_PREFIX=$G4INSTALL \
        -DGEANT4_INSTALL_DATA=ON \
        -DGEANT4_USE_GDML=ON \
        -DXERCESC_ROOT_DIR=$XERCESCROOT \
        -DCLHEP_ROOT_DIR=$CLHEP_BASE_DIR \
        -DGEANT4_BUILD_EXAMPLES=OFF \
        -DGEANT4_USE_OPENGL_X11=ON \
        -DGEANT4_BUILD_MULTITHREADED=ON \
        -DGEANT4_USE_XM=ON \
        -DGEANT4_USE_QT=ON \
        -DCMAKE_CXX_FLAGS= \
        -I$QTDIR/include \
    		-I$QTDIR/include/QtOpenGL \
    		-I$QTDIR/include/QtWidgets \
    		-I$QTDIR/include/QtGui \
    		-I$QTDIR/include/QtCore \
    		-I$QTDIR/include/QtPrintSupport \
        "-W -Wall -pedantic -Wno-non-virtual-dtor -Wno-long-long -Wwrite-strings -Wpointer-arith -Woverloaded-virtual -pipe" \
        .. \
    && make -j$(nproc) && make install

#SCONS
ENV SCONS_BM_VERSION $JLAB_VERSION
ENV SCONS_BM $JLAB_ROOT/$JLAB_VERSION/scons_bm/$JLAB_VERSION
ENV SCONSFLAGS --site-dir $JLAB_ROOT/$JLAB_VERSION/scons_bm/$JLAB_VERSION

#ENV QTDIR /usr/include/qt4
ENV PKG_CONFIG_PATH $QTDIR/lib/pkgconfig:/usr/lib/pkgconfig:$PKG_CONFIG_PATH

RUN rm -rf $JLAB_ROOT/$JLAB_VERSION/scons_bm/$SCONS_BM_VERSION \
    && mkdir -p $JLAB_ROOT/$JLAB_VERSION/scons_bm/ \
    && cd $JLAB_ROOT/$JLAB_VERSION/scons_bm/ \
    && wget $BASE_URL/scons_bm/scons_bm-$SCONS_BM_VERSION.tar.gz \
    && tar -zxpvf scons_bm-$SCONS_BM_VERSION.tar.gz \
    && rm -rf scons_bm-$SCONS_BM_VERSION.tar.gz

## mysql
RUN apt-get install -y libmysqlclient-dev
ENV MYSQL $JLAB_SOFTWARE/mysql
ENV MYSQINC $JLAB_SOFTWARE/mysql/include
ENV MYSQLIB $JLAB_SOFTWARE/mysql/lib
ENV MYSQBIN $JLAB_SOFTWARE/mysql/bin
ENV MYSQLINC $JLAB_SOFTWARE/mysql/include
ENV MYSQL_INCLUDE_PATH $JLAB_SOFTWARE/mysql/include
ENV MYSQL_LIB_PATH $JLAB_SOFTWARE/mysql/lib

RUN mkdir -p $JLAB_SOFTWARE/mysql \
    && ln -sfn /usr/lib64/mysql $JLAB_SOFTWARE/mysql/lib

## mlibrary
ENV GIT_SSL_NO_VERIFY false
ENV MLIBRARY_VERSION $JLAB_VERSION
ENV MLIBRARY $JLAB_SOFTWARE/mlibrary/$JLAB_VERSION
ENV Geant4_DIR $JLAB_SOFTWARE/geant4/$GEANT4_VERSION/lib/Geant4-10.3.1/

RUN mkdir -p $JLAB_SOFTWARE/mlibrary \
    && cd $JLAB_SOFTWARE/mlibrary \
    && wget $BASE_URL/mlibrary/mlibrary-$MLIBRARY_VERSION.tar.gz \
    && tar -zxpvf mlibrary-$MLIBRARY_VERSION.tar.gz \
    && rm -rf mlibrary-$MLIBRARY_VERSION.tar.gz \
    && cd $JLAB_SOFTWARE/mlibrary/$MLIBRARY_VERSION \
    && scons -j$(nproc) OPT=1 \
    && git clone https://github.com/christopherpoole/CADMesh.git cadmesh \
    && mkdir cadmeshBuild \
    && cd cadmeshBuild \
    && cmake ../cadmesh \
        -DCMAKE_INSTALL_PREFIX:PATH=$MLIBRARY \
        -DCMAKE_PREFIX_PATH=$JLAB_SOFTWARE/geant4/$GEANT4_VERSION \
    && make -j$(nproc) \
    && make install

## CCDB
ENV CCDB_VERSION github
ENV CCDB_HOME $JLAB_SOFTWARE/ccdb
ENV CCDB_USER root

RUN cd $JLAB_SOFTWARE \
    && git clone https://github.com/JeffersonLab/ccdb.git \
    && cd $CCDB_HOME \
    && scons -j$(nproc)

## EVIO
ENV EVIO_VERSION 5.1
ENV EVIO $JLAB_SOFTWARE/evio/$EVIO_VERSION

RUN mkdir -p $JLAB_SOFTWARE/evio && cd $JLAB_SOFTWARE/evio \
    && wget $BASE_URL/evio/evio-$EVIO_VERSION.tar.gz \
    && tar -zxpvf evio-$EVIO_VERSION.tar.gz \
    && rm -rf evio-$EVIO_VERSION.tar.gz \
    && cd $EVIO_VERSION \
    && scons -j$(nproc)

## gemc
ENV GEMC_VERSION devel
ENV GEMC $JLAB_SOFTWARE/gemc/$JLAB_VERSION
ENV CCDB_HOME /usr/local/jlab_software/x86_64/devel/ccdb/ccdb-1.06.02

RUN rm -rf $JLAB_SOFTWARE/gemc/$GEMC_VERSION \
    && mkdir -p $JLAB_SOFTWARE/gemc \
    && cd $JLAB_SOFTWARE/gemc \
    && git clone https://github.com/gemc/source.git $GEMC_VERSION

COPY PhysicsList.cc $JLAB_SOFTWARE/gemc/$GEMC_VERSION/physics/
COPY clas12.gcard /root/
ENV CLHEP_BASE_DIR /usr/include/CLHEP
ENV XERCESCROOT /usr/include/xercesc
ENV CCDB_HOME $JLAB_SOFTWARE/ccdb
RUN cd $JLAB_SOFTWARE/gemc/$GEMC_VERSION \
    && scons -j$(nproc) OPT=1


## banks
#ENV BANKS_VERSION $JLAB_VERSION
#ENV BANKS $JLAB_SOFTWARE/banks/$JLAB_VERSION

#RUN mkdir -p $JLAB_SOFTWARE/banks \
#    && cd $JLAB_SOFTWARE/banks \
#    && wget $BASE_URL/banks/banks-$BANKS_VERSION.tar.gz \
#    && tar -zxpvf banks-$BANKS_VERSION.tar.gz \
#    && rm -rf banks-$BANKS_VERSION.tar.gz \
#    && cd $BANKS_VERSION \
#    && scons -j$(nproc)

## jana
#ENV JANA_VERSION 0.7.7p1
#ENV JANA_HOME $JLAB_SOFTWARE/jana/$JANA_VERSION
#ENV BMS_OSNAME devel

#RUN mkdir -p $JANA_HOME \
#    && cd $JLAB_SOFTWARE/jana \
#    && wget $BASE_URL/jana/jana_$JANA_VERSION.tgz \
#    && tar -zxpvf jana_$JANA_VERSION.tgz \
#    && rm -rf jana_$JANA_VERSION.tgz \
#    && cd jana_$JANA_VERSION \
#    && scons -j$(nproc) install \
#    && mv $BMS_OSNAME/* $JANA_HOME \
#    && rm -rf $JANA_HOME/src \
#    && rm -rf $JLAB_SOFTWARE/jana/$filename \
#    && rm -rf $JLAB_SOFTWARE/jana/jana_$JANA_VERSION


ENTRYPOINT ["/bin/bash"]
