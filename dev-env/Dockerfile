FROM tylern4/rootv6:ubuntu
#FROM tylern4/rootv6:centos
LABEL maintainer "tylern@jlab.org"

RUN pip install --upgrade pip setuptools \
    # && pip install --upgrade --force-reinstall --ignore-installed --no-binary :all: \
    && pip install \
      termcolor \
      colorama \
      tqdm \
      cython \
      iminuit \
      rootpy \
      numpy \
      pandas \
      dask \
      scipy \
      ipyparallel \
      bokeh \
      networkx \
      ggplot \
      matplotlib \
      plotly \
      brewer2mpl \
      scikit-learn \
      scikit-build \
      seaborn \
      root2matplot \
      biopython

RUN ROOTSYS=$ROOTSYS pip install root-numpy

COPY zshrc /root/.zshrc
copy oh-my-zsh /root/.oh-my-zsh

WORKDIR /root/code

ENTRYPOINT ["/bin/zsh"]
