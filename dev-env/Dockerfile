FROM tylern4/rootv6:ubuntu
LABEL maintainer "tylern@jlab.org"

RUN pip install --upgrade pip setuptools \
    #&& pip install -U --no-binary :all: \
    && pip install -U \
      mpi4py \
      numba \
      termcolor \
      colorama \
      tqdm \
      cython \
      iminuit \
      rootpy \
      numpy \
      pandas \
      dask \
      ipyparallel \
      bokeh \
      networkx \
      matplotlib \
      plotly \
      brewer2mpl \
      seaborn \
      root2matplot \
      biopython \
      pymongo \
      sqlalchemy \
      psycopg2 \
      scipy \
      scikit-learn \
      scikit-build \
      ggplot \
      odo

RUN ROOTSYS=$ROOTSYS pip install root-numpy

COPY zshrc /root/.zshrc
copy oh-my-zsh /root/.oh-my-zsh

WORKDIR /root/code

ENTRYPOINT ["/bin/zsh"]
