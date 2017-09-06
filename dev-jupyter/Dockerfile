FROM tylern4/dev-env:centos
LABEL maintainer "tylern@jlab.org"

#RUN apt-get install -y libblas-dev liblapack-dev

#RUN pip install --upgrade pip \
#    && pip install --upgrade --force-reinstall --ignore-installed --no-binary :all: \
#    termcolor \
#    colorama \
#    tqdm \
#    cython \
#    iminuit \
#    rootpy \
#    numpy \
#    pandas \
#    dask \
#    scipy \
#    jupyter \
#    jupyterhub \
#    jupyterlab \
#    ipyparallel \
#    bokeh \
#    networkx \
#    ggplot \
#    matplotlib \
#    plotly \
#    brewer2mpl \
#    scikit-learn \
#    scikit-build \
#    seaborn


RUN pip install jupyter \
    ipyparallel

RUN ipcluster nbextension enable
RUN ROOTSYS=$ROOTSYS pip install --upgrade root-numpy

ENV NB_USER tylern
ENV NB_UID 1000
ENV HOME /home/$NB_USER
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER

USER $NB_USER
RUN mkdir /home/$NB_USER/work && \
    mkdir /home/$NB_USER/.jupyter && \
    echo "cacert=/etc/ssl/certs/ca-certificates.crt" > /home/$NB_USER/.curlrc

USER root
EXPOSE 9999
COPY jupyter /home/$NB_USER/.jupyter
COPY ipython.sh /home/$NB_USER/.jupyter/
RUN chown -R $NB_USER:users /home/$NB_USER/.jupyter

USER $NB_USER
WORKDIR /home/$NB_USER/

ENTRYPOINT [".jupyter/ipython.sh"]
