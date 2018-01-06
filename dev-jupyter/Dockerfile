FROM tylern4/rootv6:ubuntu
LABEL maintainer "tylern@jlab.org"

RUN pip install --upgrade pip setuptools \
    && pip --no-cache-dir install -U \
	rootpy \
	numpy \
    pandas \
    matplotlib \
    scikit-learn \
    jupyter \
    ipyparallel \
    sqlalchemy \
    pymongo \
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
    plotly \
    brewer2mpl \
    seaborn \
    root2matplot \
    scikit-build \
    ggplot \
    odo

RUN ipcluster nbextension enable

RUN ROOTSYS=$ROOTSYS pip install root-numpy

ENV NB_USER jupyter
ENV NB_UID 1000
ENV HOME /home/$NB_USER

RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER

COPY jupyter /home/$NB_USER/.jupyter
COPY ipython.sh /home/$NB_USER/.jupyter/

RUN mkdir -p /home/$NB_USER/work && \
    chown -R $NB_USER /home/$NB_USER/.jupyter && \
    mkdir -p /home/$NB_USER/code && \
    echo "cacert=/etc/ssl/certs/ca-certificates.crt" > /home/$NB_USER/.curlrc 

EXPOSE 9999
RUN chown -R $NB_USER:users /home/$NB_USER/.jupyter

USER $NB_USER
WORKDIR /home/$NB_USER/
ENTRYPOINT [".jupyter/ipython.sh"]
