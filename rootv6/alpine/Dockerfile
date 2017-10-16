FROM alpine
ENV TERM xterm

ENV ROOTSYS /usr/local/root
ENV PATH $ROOTSYS/bin:$PATH
ENV PYTHONDIR $PYTHONDIR:$ROOTSYS
ENV LD_LIBRARY_PATH $ROOTSYS/lib:$PYTHONDIR/lib:$ROOTSYS/bindings/pyroot:$LD_LIBRARY_PATH
ENV DYLD_LIBRARY_PATH /usr/lib:$ROOTSYS/lib:$PYTHONDIR/lib:$ROOTSYS/bindings/pyroot:$DYLD_LIBRARY_PATH
ENV PYTHONPATH $PYTHONPATH:$ROOTSYS/lib:$ROOTSYS/bindings/pyroot

RUN apk add --update alpine-sdk build-base zsh

RUN cd /tmp/ \
    && git clone https://github.com/root-project/root.git

RUN apk add cmake python bash
RUN apk add build-base python-dev py-pip zlib-dev musl-dev
ENV LIBRARY_PATH=/lib:/usr/lib

RUN cd /tmp/root \
    && mkdir compile \
    && cd compile \
    && cmake -Dfortran=ON -Dpython=ON -Dcxx11=ON -Droofit=ON -Dx11=OFF \
    -DCMAKE_INSTALL_PREFIX:PATH=/usr/local/root .. | tee /root/config.txt \
    && make -j$(nproc) | tee /root/build.txt && make && make install \
    && rm -rf /tmp/root

ENTRYPOINT ["root.exe","-qb" ]
#cd $ROOTSYS && source bin/thisroot.sh && cd && root -b
