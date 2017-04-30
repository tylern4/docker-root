#FROM tylern4/rootv6:ubuntu_py3
FROM tylern4/rootv6:centos7_py3
LABEL maintainer "tylern@jlab.org"

COPY zshrc /root/.zshrc
copy oh-my-zsh /root/.oh-my-zsh

WORKDIR /root/code

ENTRYPOINT ["/bin/zsh"]
