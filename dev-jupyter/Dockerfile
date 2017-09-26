FROM tylern4/dev-env:ubuntu
LABEL maintainer "tylern@jlab.org"

RUN pip install -U --no-binary :all: \
    jupyter \
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
