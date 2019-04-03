FROM tylern4/rootv6:6_12_02_py3
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
    odo \
    scilab_kernel

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

## Extra Kernels
#WORKDIR /tmp
#RUN git clone https://github.com/sourceryinstitute/jupyter-CAF-kernel \
#    && cd jupyter-CAF-kernel \
#    && pip install -e prebuild/jupyter-caf-kernel \
#    && jupyter-kernelspec install prebuild/jupyter-caf-kernel/Coarray-Fortran \
#    && rm -rf /tmp/*

#ENV JAVA_HOME /usr/lib/jvm/jdk-9
#ENV PATH $PATH:/usr/lib/jvm/jdk-9/bin
#RUN wget --quiet http://download.java.net/java/GA/jdk9/9.0.1/binaries/openjdk-9.0.1_linux-x64_bin.tar.gz \
#    && tar -xvf openjdk-9.0.1_linux-x64_bin.tar.gz \
#    && mkdir -p /usr/lib/jvm/jdk-9 \
#    && mv jdk-9.0.1/* /usr/lib/jvm/jdk-9 \
#    && update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk-9/bin/java" 0 \
#    && update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk-9/bin/javac" 0 \
#    && update-alternatives --set java /usr/lib/jvm/jdk-9/bin/java \
#    && update-alternatives --set javac /usr/lib/jvm/jdk-9/bin/javac \
#    && rm -rf /tmp/*
#ENV PATH $PATH:/usr/local/bin:/home/$NB_USER/.local/bin
#RUN chown -R root:root /home/$NB_USER
#RUN apt-get update && apt-get install -y \
#    libtinfo-dev \
#    libzmq3-dev \
#    libcairo2-dev \
#    libpango1.0-dev \
#    libmagic-dev \
#    libblas-dev \
#    liblapack-dev \
#    && wget -qO- https://get.haskellstack.org/ | sh \
#    && git clone https://github.com/gibiansky/IHaskell \
#    && cd IHaskell \
#    && pip install -r requirements.txt \
#    && stack install --fast \
#    && ihaskell install --stack \
#    && rm -rf /var/lib/apt/lists/* \
#    && rm -rf /tmp/*

EXPOSE 9999
RUN chown -R $NB_USER:users /home/$NB_USER

USER $NB_USER
WORKDIR /home/$NB_USER/
ENTRYPOINT [".jupyter/ipython.sh"]
