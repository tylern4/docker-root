FROM ubuntu:latest
ENV TERM xterm
ENV PLUGIN 4a.4.0

ENV MAVEN_VERSION 3.3.3
ENV GROOVY_VERSION 2.4.12
ENV GRADLE_VERSION 4.1

ENV MAVEN_HOME /usr/local/maven

ENV CLARA_HOME /usr/local/clara
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install git cmake make software-properties-common \
    python-software-properties gcc g++ build-essential \
    libzmq3-dev python-dev libprotobuf-dev protobuf-compiler unzip \
    zsh tcsh vim nano emacs wget

#RUN add-apt-repository -y ppa:webupd8team/java \
#    && apt-get update \
#    && echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
#    && echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections \
#    && apt-get install -y oracle-java8-installer oracle-java8-set-default

RUN apt-get install -y openjdk-8-jdk

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

WORKDIR /tmp/

RUN wget --quiet https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-all.zip \
    && unzip gradle-$GRADLE_VERSION-all.zip \
    && mv gradle-$GRADLE_VERSION /usr/local/gradle \
    && rm -rf /tmp/*

RUN wget --quiet http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz -O - | tar xzf - \
    && mv apache-maven-$MAVEN_VERSION /usr/local/maven \
    && rm -rf /tmp/*

RUN wget --quiet https://dl.bintray.com/groovy/maven/apache-groovy-binary-$GROOVY_VERSION.zip \
    && unzip apache-groovy-binary-$GROOVY_VERSION.zip \
    && mv groovy-$GROOVY_VERSION /usr/local/groovy \
    && rm -rf /tmp/*

ENV PATH /usr/local/bin:/usr/local/groovy/bin:/usr/local/gradle/bin:/usr/local/maven/bin:$PATH


RUN mkdir -p $CLARA_HOME/plugins/clas12/config
RUN mkdir -p $CLARA_HOME/clara-dk
RUN mkdir -p $CLARA_HOME/data/input
RUN mkdir -p $CLARA_HOME/data/output

WORKDIR $CLARA_HOME/clara-dk

RUN git clone --depth 1 https://github.com/JeffersonLab/xmsg-cpp.git \
    && cd xmsg-cpp \
    && ./configure --prefix=$CLARA_HOME/clara-dk/xmsg-cpp \
    && make -j$(nproc) \
    && make install

RUN git clone --depth 1 https://github.com/JeffersonLab/xmsg_python.git \
    && cd xmsg_python \
    && apt-get -y install python-pip \
    && pip install --upgrade pip \
    && pip install -r requirements.txt \
    && ./setup.py install

RUN git clone --depth 1 https://github.com/JeffersonLab/xmsg-java.git \
    && cd xmsg-java \
    && ./gradlew install

RUN git clone --depth 1 https://github.com/JeffersonLab/JinFlux.git \
    && cd JinFlux \
    && gradle deploy

RUN git clone --depth 1 https://github.com/JeffersonLab/clara-java.git \
    && cd clara-java \
    && ./gradlew install \
    && ./gradlew deploy


RUN git clone --depth 1 https://github.com/JeffersonLab/clasrec-io.git \
    && cd clasrec-io \
    && ./gradlew deploy

RUN git clone --depth 1 https://github.com/JeffersonLab/clasrec-orchestrators.git \
    && cd clasrec-orchestrators \
    && ./gradlew deploy


RUN mkdir -p $CLARA_HOME/jre

WORKDIR /tmp/

RUN wget --quiet http://clasweb.jlab.org/clas12offline/distribution/coatjava/coatjava-$PLUGIN.tar.gz \
    && tar xvzf coatjava-$PLUGIN.tar.gz \
    && cd coatjava \
    && cp -r * $CLARA_HOME/plugins/clas12/ \
    && rm -rf /tmp/*

RUN wget https://userweb.jlab.org/~gurjyan/clara-cre/linux-64.tar.gz \
    && tar -xvf linux-64.tar.gz \
    && rm -rf linux-64.tar.gz \
    && mv * $CLARA_HOME/jre/

ENV PATH $PATH:/$CLARA_HOME/bin:$CLARA_HOME/plugins/clas12/bin

COPY input $CLARA_HOME/data/input

WORKDIR /root/code
ENTRYPOINT ["/bin/tcsh"]
