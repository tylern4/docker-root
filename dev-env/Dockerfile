FROM tylern4/rootv6:ubuntu
LABEL maintainer "tylern@jlab.org"
COPY zshrc /root/.zshrc
COPY oh-my-zsh /root/.oh-my-zsh

RUN pip3 install --upgrade pip setuptools \
    && pip3 --no-cache-dir install -U \
      numpy \
      pandas \
      matplotlib \
      scipy \
      scikit-learn \
      ipyparallel \
      mpi4py \
      numba \
      termcolor \
      colorama \
      tqdm \
      cython \
      iminuit \
      dask \
      xarray \
      bokeh \
      plotly \
      seaborn \
      ggplot \
      odo

RUN ROOTSYS=$ROOTSYS pip3 install root-numpy uproot rootpy

WORKDIR /usr/local/src/
RUN git clone https://github.com/tylern4/hipopy.git \
    && cd hipopy \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j$(nproc) \
    && make install

WORKDIR /root/code
ENTRYPOINT ["/bin/zsh"]
