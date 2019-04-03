FROM tylern4/rootv6:py3
LABEL maintainer "tylern@jlab.org"
COPY zshrc /home/user/.zshrc
COPY oh-my-zsh /home/user/.oh-my-zsh

USER root
RUN ROOTSYS=$ROOTSYS pip3 install root-numpy uproot rootpy
RUN rm -rf /usr/bin/python && ln -s /usr/bin/python3 /usr/bin/python 

COPY physics_code /usr/local/src/physics_code
RUN cd /usr/local/src/physics_code/current \
    && mkdir build \
    && cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local/physics \
    && make -j$(nproc) \
    && make install

USER user
WORKDIR /home/user
ENTRYPOINT ["/bin/zsh"]
