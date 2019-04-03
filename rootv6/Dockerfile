FROM tylern4/rootv6:base
LABEL maintainer "tylern@jlab.org"
ENV TERM xterm

WORKDIR /tmp/

ENV ROOT_VER v6-14-00

RUN wget --quiet https://github.com/root-project/root/archive/$ROOT_VER.tar.gz \
    && tar -xf $ROOT_VER.tar.gz \
    && rm -rf $ROOT_VER.tar.gz \
    && cd /tmp/root* \
    && mkdir compile \
    && cd compile \
    && cmake \
        -DCMAKE_CXX_FLAGS=-D_GLIBCXX_USE_CXX11_ABI=0 \
        -DCMAKE_INSTALL_PREFIX:PATH=/usr/local/root \
        -Dcxx17=ON -Dpython=ON -Droot7=ON -Droofit=ON -Dbuiltin_xrootd=ON .. \
    && make -j$(nproc) && make && make install \
    && rm -rf /tmp/*

ENV PYTHIA /usr/local/pythia
ENV PYTHIA8 $PYTHIA/pythia8
ENV PYTHIA8DATA /usr/local/pythia/pythia8/xmldoc
ENV PYTHIAVERSION pythia8240

RUN wget --quiet http://home.thep.lu.se/~torbjorn/pythia8/$PYTHIAVERSION.tgz \
    && tar -xvf $PYTHIAVERSION.tgz \
    && rm -rf $PYTHIAVERSION.tgz \
    && cd pythia* \
    && ./configure --enable-shared \
    --with-python --with-python-include=/usr/include/python2.7 \
    --with-root --with-root-lib=/usr/local/root/lib --with-root-include=/usr/local/root/include --prefix=$PYTHIA8\
    && make -j$(nproc) && make install \
    && rm -rf /tmp/*

ENV PYTHONPATH $PYTHONPATH:$(ls -d $PYTHIA8/* | head -n 1)/lib

COPY root-entrypoint.sh /usr/local/sbin

ENTRYPOINT ["/usr/local/sbin/root-entrypoint.sh"]
