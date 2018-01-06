FROM ubuntu:latest
LABEL maintainer "tylern@jlab.org"
ENV TERM xterm

ENV ROOTSYS /usr/local/root
ENV PATH $ROOTSYS/bin:$PATH
ENV PYTHONDIR $PYTHONDIR:$ROOTSYS
ENV LD_LIBRARY_PATH $ROOTSYS/lib:$PYTHONDIR/lib:$ROOTSYS/bindings/pyroot:$LD_LIBRARY_PATH
ENV DYLD_LIBRARY_PATH /usr/lib:$ROOTSYS/lib:$PYTHONDIR/lib:$ROOTSYS/bindings/pyroot:$DYLD_LIBRARY_PATH
ENV PYTHONPATH $PYTHONPATH:$ROOTSYS/lib:$ROOTSYS/bindings/pyroot

RUN apt-get -y update && apt-get -y install --reinstall \
    openmpi-bin libopenmpi-dev apt-utils \
    && apt-get -y install zsh perl git dpkg-dev make cmake g++ gcc python-dev \
    python-pip curl wget gfortran \
    binutils scons liblz4-dev \
    #libxft-dev libxext-dev  libssl-dev libpcre3-dev libx11-dev libxpm-dev \
    #xlibmesa-glu-dev libglew1.5-dev libftgl-dev \
    #libmysqlclient-dev libfftw3-dev libcfitsio-dev \
    #graphviz-dev libavahi-compat-libdnssd-dev llvm-dev lzma-dev \
    #libldap2-dev  libxml2-dev libkrb5-dev \
    #libgsl0-dev libqt4-dev python-tk python3-dev \
    && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

#RUN locale-gen en_US.UTF-8
#ENV LANG en_US.UTF-8
#ENV LANGUAGE en_US:en
#ENV LC_ALL en_US.UTF-8

WORKDIR /tmp/
RUN wget --quiet https://github.com/root-project/root/archive/v6-06-08.tar.gz \
    && tar -xf v6-06-08.tar.gz \
    && rm -rf v6-06-08.tar.gz \
    && cd /tmp/root* \
    && mkdir compile \
    && cd compile \
    && cmake \
      -Droofit=ON \
      -Dcxx17=ON \
      -Dlibcxx=ON \
      -Dcling=ON \
      -Dfortran=ON \
      -Dminuit2=ON \
      -Dbuiltin_zlib=ON \
      -Dafdsmgrd=OFF \
      -Dafs=OFF \
      -Dalien=OFF \
      -Dall=OFF \
      -Dasimage=OFF \
      -Dastiff=OFF \
      -Dbonjour=OFF \
      -Dbuiltin_afterimage=OFF \
      -Dbuiltin_fftw3=OFF \
      -Dbuiltin_ftgl=OFF \
      -Dbuiltin_freetype=OFF \
      -Dbuiltin_glew=OFF \
      -Dbuiltin_pcre=OFF \
      -Dbuiltin_lzma=OFF \
      -Dbuiltin_davix=OFF \
      -Dbuiltin_gsl=OFF \
      -Dbuiltin_cfitsio=OFF \
      -Dbuiltin_xrootd=OFF \
      -Dbuiltin_llvm=ON \
      -Dbuiltin_tbb=OFF \
      -Dcastor=OFF \
      -Dccache=OFF \
      -Dchirp=OFF \
      -Ddcache=OFF \
      -Dexceptions=OFF \
      -Dfail-on-missing=OFF \
      -Dfftw3=OFF \
      -Dfitsio=OFF \
      -Dgdml=OFF \
      -Dgeocad=OFF \
      -Dgenvector=OFF \
      -Dgfal=OFF \
      -Dglite=OFF \
      -Dglobus=OFF \
      -Dgminimal=OFF \
      -Dgnuinstall=OFF \
      -Dgsl_shared=OFF \
      -Dgviz=OFF \
      -Dhdfs=OFF \
      -Dimt=OFF \
      -Djemalloc=OFF \
      -Dkrb5=OFF \
      -Dldap=OFF \
      -Dmathmore=OFF \
      -Dmemstat=OFF \
      -Dminimal=OFF \
      -Dmonalisa=OFF \
      -Dmt=OFF \
      -Dmysql=OFF \
      -Dodbc=OFF \
      -Dopengl=OFF \
      -Doracle=OFF \
      -Dpgsql=OFF \
      -Dpythia6=OFF \
      -Dpythia6_nolink=OFF \
      -Dpythia8=OFF \
      -Dpython=ON \
      -Dqt=OFF \
      -Dqtgsi=OFF \
      -Droot7=OFF \
      -Droottest=OFF \
      -Druby=OFF \
      -Dr=OFF \
      -Drfio=OFF \
      -Drpath=OFF \
      -Dsapdb=OFF \
      -Dshadowpw=OFF \
      -Dshared=OFF \
      -Dsoversion=OFF \
      -Dsqlite=OFF \
      -Dsrp=OFF \
      -Dssl=OFF \
      -Dtbb=OFF \
      -Dtable=OFF \
      -Dtcmalloc=OFF \
      -Dtesting=OFF \
      -Dthread=OFF \
      -Dtmva=OFF \
      -Dunuran=OFF \
      -Dvc=OFF \
      -Dvdt=OFF \
      -Dwinrtdebug=OFF \
      -Dxft=OFF \
      -Dxml=OFF \
      -Dxrootd=OFF \
      -Dx11=OFF \
        -DCMAKE_CXX_FLAGS=-D_GLIBCXX_USE_CXX11_ABI=0 \
        -DCMAKE_INSTALL_PREFIX:PATH=/usr/local/root .. \
    && make -j$(nproc) && make && make install \
    && rm -rf /tmp/*

ENV PYTHIA /usr/local/pythia
ENV PYTHIA8 $PYTHIA/pythia8
ENV PYTHIA8DATA /usr/local/pythia/pythia8/xmldoc
ENV PYTHIAVERSION pythia82
RUN mkdir $PYTHIA

RUN curl -o $PYTHIAVERSION.tgz http://home.thep.lu.se/~torbjorn/pythia8/$PYTHIAVERSION.tgz \
    && tar -xvf $PYTHIAVERSION.tgz \
    && rm -rf $PYTHIAVERSION.tgz \
    && cd pythia* \
    && ./configure --enable-shared \
    --with-python --with-python-include=/usr/include/python2.7 \
    --with-root --with-root-include=/usr/local/root/include --prefix=$PYTHIA8\
    && make -j$(nproc) && make install \
    && rm -rf /tmp/*

ENV PYTHONPATH $PYTHONPATH:$(ls -d $PYTHIA8/* | head -n 1)/lib

WORKDIR /root/
COPY root-entrypoint.sh /usr/local/sbin

ENTRYPOINT ["/usr/local/sbin/root-entrypoint.sh"]
