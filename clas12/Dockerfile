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
    libgsl0-dev libqt4-dev python-pip wget curl python-tk \
    scons libxmu-dev libx11-dev libclhep-dev libxerces-c3-dev \
    qt4-dev-tools freeglut3-dev libmotif-dev tk-dev libxi-dev \
    && apt-get clean

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
    -static \
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

## CLHEP
#RUN apt-get install -y libclhep-dev
#ENV CLHEP_VERSION 2.3.4.3
#ENV CLHEP_BASE_DIR $JLAB_SOFTWARE/clhep/$CLHEP_VERSION

#RUN wget $BASE_URL/clhep/clhep-$CLHEP_VERSION.tgz \
#    && tar -zxpvf clhep-$CLHEP_VERSION.tgz \
#    && rm -rf clhep-$CLHEP_VERSION.tgz \
#    && cd $CLHEP_VERSION \
#    && rm -rf build && mkdir build && cd build \
#    && cmake -DCMAKE_INSTALL_PREFIX=$CLHEP_BASE_DIR ../CLHEP \
#    && make -j$(nproc) \
#    && make install

## XERCESC
#RUN apt-get install -y libxerces-c3-dev
#ENV XERCESC_VERSION 3.1.4
#ENV XERCESCROOT $JLAB_SOFTWARE/xercesc/$XERCESC_VERSION

#RUN wget $BASE_URL/xercesc/xerces-c-$XERCESC_VERSION.tar.gz \
#    && tar -zxpvf xerces-c-$XERCESC_VERSION.tar.gz \
#    && rm -rf xerces-c-$XERCESC_VERSION.tar.gz \
#    && cd xerces-c-$XERCESC_VERSION \
#    && ./configure -prefix=$XERCESCROOT \
#    && make -j$(nproc) \
#    && make install

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
        "-W -Wall -pedantic -Wno-non-virtual-dtor -Wno-long-long -Wwrite-strings -Wpointer-arith -Woverloaded-virtual -pipe" \
        .. \
    && make -j$(nproc) && make install

#SCONS
ENV SCONS_BM_VERSION $JLAB_VERSION
ENV SCONS_BM $JLAB_ROOT/$JLAB_VERSION/scons_bm/$JLAB_VERSION
ENV SCONSFLAGS --site-dir $JLAB_ROOT/$JLAB_VERSION/scons_bm/$JLAB_VERSION

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

#ENV CCDB_VERSION 1.06.02
#ENV CCDB_HOME /usr/local/jlab_software/x86_64/devel/ccdb/ccdb-1.06.02
#ENV CCDB_USER root
#RUN mkdir -p $JLAB_SOFTWARE/ccdb \
#    && cd $JLAB_SOFTWARE/ccdb \
#    && wget $BASE_URL/ccdb/ccdb-$CCDB_VERSION.tar.gz \
#    && tar -zxpvf ccdb-$CCDB_VERSION.tar.gz \
#    && rm -rf ccdb-$CCDB_VERSION.tar.gz \
#    && cd $JLAB_SOFTWARE/ccdb/ccdb-$CCDB_VERSION \
#    && scons -j$(nproc) \
#    && mkdir -p $CCDB_HOME \
#    && cp -r $JLAB_SOFTWARE/ccdb/ccdb-$CCDB_VERSION $CCDB_HOME

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
    #&& wget $BASE_URL/gemc/gemc-$GEMC_VERSION.tar.gz \
    #&& tar -zxpvf gemc-$GEMC_VERSION.tar.gz \
    #&& rm -rf gemc-$GEMC_VERSION.tar.gz

#ENV LD_LIBRARY_PATH $QTDIR/lib:$LD_LIBRARY_PATH
#COPY PhysicsList.cc $JLAB_SOFTWARE/gemc/$GEMC_VERSION/physics/
ENV CLHEP_BASE_DIR /usr/include/CLHEP
ENV XERCESCROOT /usr/include/xercesc
ENV CCDB_HOME $JLAB_SOFTWARE/ccdb
RUN cd $JLAB_SOFTWARE/gemc/$GEMC_VERSION \
    #&& ln -s /usr/local/Qt/5.5/gcc_64/lib/libicui18n.so.54 /usr/lib/x86_64-linux-gnu/libicui18n.so.54 \
    #&& ln -s /usr/local/Qt/5.5/gcc_64/lib/libicuuc.so.54 /usr/lib/x86_64-linux-gnu/libicuuc.so.54 \
    #&& ln -s /usr/local/Qt/5.5/gcc_64/lib/libicudata.so.54 /usr/lib/x86_64-linux-gnu/libicudata.so.54 \
    #&& cp -r /usr/local/jlab_software/devel/x86_64/ccdb/ccdb-1.06.02/include/* hitprocess/clas12/. \
    #&& mkdir lib \
    #&& ln -s /usr/local/jlab_software/devel/x86_64/ccdb/ccdb-1.06.02/lib/* lib \
    && scons -j$(nproc) LIBRARY=shared OPT=1

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


##

#RUN ./go_clhep ##
#RUN ./go_xercesc ##
#RUN ./go_qt *?
#RUN ./go_geant4 ##
#RUN ./go_sconsscript ##
#RUN ./go_evio ##
#RUN ./go_mysql ##
#RUN ./go_ccdb ##
#RUN ./go_mlibrary
#RUN ./go_gemc
#RUN ./go_fields
#RUN ./go_banks
#RUN ./go_jana


#    -no-zlib \
#    -no-xkbcommon \
#    -no-freetype \
#    -no-harfbuzz \
#    -no-xcb \
#		-no-feature-accessibility \
#		-no-feature-texthtmlparser \
#		-no-feature-textodfwriter \
#		-no-feature-cssparser \
#		-no-feature-regularexpression \
#		-no-feature-concurrent \
#		-no-feature-draganddrop \
#		-no-feature-sessionmanager \
#		-no-feature-shortcut \
#		-no-feature-action \
#		-no-feature-cursor \
#		-no-feature-clipboard \
#		-no-feature-wheelevent \
#		-no-feature-tabletevent \
#		-no-feature-effects \
#		-no-feature-sharedmemory \
#		-no-feature-systemsemaphore \
#		-no-feature-xmlstream \
#		-no-feature-xmlstreamreader \
#		-no-feature-xmlstreamwriter \
#		-no-feature-im \
#		-no-feature-textdate \
#		-no-feature-datestring \
#		-no-feature-process \
#		-no-feature-temporaryfile \
#		-no-feature-library \
#		-no-feature-settings \
#		-no-feature-dom \
#		-no-feature-filesystemmodel \
#		-no-feature-filesystemwatcher \
#		-no-feature-filesystemiterator \
#		-no-feature-treewidget \
#		-no-feature-listwidget \
#		-no-feature-tablewidget \
#		-no-feature-datetimeedit \
#		-no-feature-stackedwidget \
#		-no-feature-textbrowser \
#		-no-feature-splashscreen \
#		-no-feature-splitter \
#		-no-feature-lcdnumber \
#		-no-feature-menu \
#		-no-feature-lineedit \
#		-no-feature-spinbox \
#		-no-feature-tabbar \
#		-no-feature-tabwidget \
#		-no-feature-combobox \
#		-no-feature-fontcombobox \
#		-no-feature-toolbutton \
#		-no-feature-toolbar \
#		-no-feature-toolbox \
#		-no-feature-groupbox \
#		-no-feature-buttongroup \
#		-no-feature-mainwindow \
#		-no-feature-dockwidget \
#		-no-feature-mdiarea \
#		-no-feature-resizehandler \
#		-no-feature-statusbar \
#		-no-feature-menubar \
#		-no-feature-contextmenu \
#		-no-feature-progressbar \
#		-no-feature-slider \
#		-no-feature-scrollbar \
#		-no-feature-dial \
#		-no-feature-scrollarea \
#		-no-feature-graphicsview \
#		-no-feature-graphicseffect \
#		-no-feature-textedit \
#		-no-feature-syntaxhighlighter \
#		-no-feature-rubberband \
#		-no-feature-tooltip \
#		-no-feature-statustip \
#		-no-feature-whatsthis \
#		-no-feature-validator \
#		-no-feature-sizegrip \
#		-no-feature-calendarwidget \
#		-no-feature-printpreviewwidget \
#		-no-feature-keysequenceedit \
#		-no-feature-messagebox \
#		-no-feature-colordialog \
#		-no-feature-filedialog \
#		-no-feature-fontdialog \
#		-no-feature-printdialog \
#		-no-feature-printpreviewdialog \
#		-no-feature-progressdialog \
#		-no-feature-inputdialog \
#		-no-feature-errormessage \
#		-no-feature-wizard \
#		-no-feature-itemviews \
#		-no-feature-dirmodel \
#		-no-feature-standarditemmodel \
#		-no-feature-proxymodel \
#		-no-feature-sortfilterproxymodel \
#		-no-feature-identityproxymodel \
#		-no-feature-stringlistmodel \
#		-no-feature-listview \
#		-no-feature-tableview \
#		-no-feature-treeview \
#		-no-feature-datawidgetmapper \
#		-no-feature-columnview \
#		-no-feature-imageformatplugin \
#		-no-feature-movie \
#		-no-feature-image_heuristic_mask \
#		-no-feature-image_text \
#		-no-feature-picture \
#		-no-feature-colornames \
#		-no-feature-pdf \
#		-no-feature-printer \
#		-no-feature-cups \
#		-no-feature-paint_debug \
#		-no-feature-freetype \
#		-no-feature-translation \
#		-no-feature-textcodec \
#		-no-feature-codecs \
#		-no-feature-big_codecs \
#		-no-feature-iconv \
#		-no-feature-ftp \
#		-no-feature-http \
#		-no-feature-udpsocket \
#		-no-feature-networkproxy \
#		-no-feature-socks5 \
#		-no-feature-networkinterface \
#		-no-feature-networkdiskcache \
#		-no-feature-bearermanagement \
#		-no-feature-localserver \
#		-no-feature-completer \
#		-no-feature-fscompleter \
#		-no-feature-desktopservices \
#		-no-feature-mimetype \
#		-no-feature-systemtrayicon \
#		-no-feature-undocommand \
#		-no-feature-undostack \
#		-no-feature-undogroup \
#		-no-feature-undoview \
#		-no-feature-accessibility \
#		-no-feature-animation \
#		-no-feature-statemachine \
#		-no-feature-gestures \
#		-no-feature-dbus \


ENTRYPOINT ["/bin/bash"]
