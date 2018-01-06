FROM tylern4/rootv6:ubuntu
LABEL maintainer "tylern@jlab.org"

RUN pip install --upgrade pip setuptools \
    && pip --no-cache-dir install -U \
      rootpy \
      numpy \
      pandas \
      matplotlib \
      scipy \
      scikit-learn

RUN ROOTSYS=$ROOTSYS pip install root-numpy

COPY zshrc /root/.zshrc
copy oh-my-zsh /root/.oh-my-zsh

WORKDIR /root/code

ENTRYPOINT ["/bin/zsh"]
