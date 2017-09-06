FROM ubuntu:latest

ENV CLARA_HOME /usr/local/clara_home
RUN apt-get update && apt-get -y upgrade

RUN apt-get -y install git cmake make software-properties-common python-software-properties

RUN add-apt-repository ppa:ubuntu-toolchain-r/test \
    && apt-get update \
    && apt-get -y install gcc g++ software-properties-common build-essential \
    libzmq3-dev python-dev libprotobuf-dev protobuf-compiler

RUN cd /tmp/ && git clone https://github.com/JeffersonLab/xmsg-cpp.git \
    && cd xmsg-cpp \
    && ./configure --prefix=/usr/local/xmsg \
    && make -j$(nproc) \
    && make install \
    && rm -rf /tmp/*

ENV xMsg_DIR /usr/local/xmsg/lib/cmake/xmsg
RUN cd /tmp/ && git clone https://github.com/JeffersonLab/clara-cpp.git && cd clara-cpp \
    && ./configure --prefix=$CLARA_HOME \
    && make -j$(nproc) \
    && make install \
    && rm -rf /tmp/*

RUN add-apt-repository ppa:webupd8team/java \
    && apt-get update \
    && echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections \
    && apt-get -y install unzip oracle-java8-installer oracle-java8-set-default

RUN wget https://services.gradle.org/distributions/gradle-4.1-all.zip \
    && mkdir /usr/local/gradle \
    && unzip -d /usr/local/gradle gradle-4.1-all.zip

ENV PATH $PATH:/usr/local/gradle/bin

RUN cd /tmp/ && git clone https://github.com/JeffersonLab/xmsg-java.git \
    && cd xmsg-java \
    && ./gradlew install \
    && rm -rf /tmp/*

RUN cd /tmp/ && git clone https://github.com/JeffersonLab/clara-java.git \
    && cd clara-java \
    && ./gradlew install \
    && rm -rf /tmp/*

RUN cd /tmp/ && git clone https://github.com/JeffersonLab/xmsg_python.git \
    && apt-get -y install python-pip \
    && cd xmsg_python \
    && pip install --upgrade pip \
    && pip install -r requirements.txt \
    && ./setup.py install \
    && rm -rf /tmp/*

ENV MAVEN_VERSION 3.3.3
RUN cd /usr/share \
 && wget --quiet http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz -O - | tar xzf - \
 && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
 && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven

RUN cd /tmp/ \
    && wget https://dl.bintray.com/groovy/maven/apache-groovy-binary-2.4.12.zip \
    && unzip -d /usr/local/ apache-groovy-binary-2.4.12.zip \
    && ln -s /usr/local/groovy-2.4.12/bin/* /usr/bin/

RUN apt-get install -y zsh vim nano
COPY zshrc /root/.zshrc
COPY oh-my-zsh /root/.oh-my-zsh
ENTRYPOINT ["/bin/zsh"]
