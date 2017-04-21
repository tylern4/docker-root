FROM java:openjdk-8
LABEL maintainer "tylern@jlab.org"

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install openjfx

ENV MAVEN_VERSION 3.3.3
RUN cd /usr/share \
 && wget --quiet http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz -O - | tar xzf - \
 && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
 && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven

ENV COATJAVA /usr/local/clas12-offline-software/coatjava/

WORKDIR /usr/local/
RUN git clone https://github.com/JeffersonLab/clas12-offline-software.git clas12-offline-software
RUN cd clas12-offline-software && git submodule update --init --recursive

WORKDIR /usr/local/clas12-offline-software

#RUN ./build-coatjava.sh
RUN mkdir coatjava \
    && cp -r bin coatjava/ \
    && cp -r etc coatjava/ \
    && cp -r lib coatjava/ \
    && mkdir coatjava/lib/services

### coat-libs ###
RUN cd common-tools \
    && mvn install

RUN cd common-tools/coat-lib \
    && mvn package

RUN cp common-tools/coat-lib/target/coat-libs*.jar coatjava/lib/clas/

### jcsg ###
RUN cd common-tools/clas-jcsg \
    && ./gradlew assemble

RUN cp common-tools/clas-jcsg/build/libs/jcsg-0.3.2.jar coatjava/lib/clas/

### create local mvn repo containing coat-libs and jcsg ##
RUN mvn deploy:deploy-file \
    -Dfile=./common-tools/coat-lib/target/coat-libs-3.0-SNAPSHOT.jar \
    -DgroupId=org.jlab.clas -DartifactId=common-tools -Dversion=0.0 \
    -Dpackaging=jar -Durl=file:./myLocalMvnRepo/ \
    -DrepositoryId=myLocalMvnRepo \
    -DupdateReleaseInfo=true

RUN mvn deploy:deploy-file \
    -Dfile=./common-tools/clas-jcsg/build/libs/jcsg-0.3.2.jar \
    -DgroupId=org.jlab.clas -DartifactId=clas-jcsg -Dversion=0.0 \
    -Dpackaging=jar -Durl=file:./myLocalMvnRepo/ \
    -DrepositoryId=myLocalMvnRepo \
    -DupdateReleaseInfo=true

### dc (depends on jcsg) ###
RUN cd reconstruction/dc \
    && mvn install

RUN cp reconstruction/dc/target/clas12detector-dc-1.0-SNAPSHOT.jar coatjava/lib/services/

### add dc jar to local mvn repo ###
RUN mvn deploy:deploy-file \
    -Dfile=./reconstruction/dc/target/clas12detector-dc-1.0-SNAPSHOT.jar \
    -DgroupId=org.jlab.service.dc -DartifactId=clas12detector-dc -Dversion=0.0 \
    -Dpackaging=jar -Durl=file:./myLocalMvnRepo/ \
    -DrepositoryId=myLocalMvnRepo \
    -DupdateReleaseInfo=true

### tof (depends on jcsg and dc) ###
RUN cd reconstruction/tof \
    && mvn install

RUN cp reconstruction/tof/target/tof-1.0-SNAPSHOT.jar coatjava/lib/services/

### cvt ###
RUN cd reconstruction/cvt \
    && mvn install

RUN cp reconstruction/cvt/target/cvt-1.0-SNAPSHOT.jar coatjava/lib/services/

### ft ###
RUN cd reconstruction/ft \
    && mvn install

RUN cp reconstruction/ft/target/clas12detector-ft-1.0-SNAPSHOT.jar coatjava/lib/services/

### ec ###
RUN cd reconstruction/ec \
    && mvn install

RUN cp reconstruction/ec/target/clas12detector-ec-1.0-SNAPSHOT.jar coatjava/lib/services/

### ltcc ###
RUN cd reconstruction/ltcc \
    && mvn install

RUN cp reconstruction/ltcc/target/clasrec-ltcc-1.0-SNAPSHOT.jar coatjava/lib/services/

### htcc ###
RUN cd reconstruction/htcc \
    && mvn install

RUN cp reconstruction/htcc/target/clasrec-htcc-1.0-SNAPSHOT.jar coatjava/lib/services/

### eb ###
RUN cd reconstruction/eb \
    && mvn install

RUN cp reconstruction/eb/target/clas12detector-eb-1.0-SNAPSHOT.jar coatjava/lib/services/

ENV PATH /usr/local/clas12-offline-software/coatjava/bin:$PATH
WORKDIR /root/

ENTRYPOINT ["/bin/bash"]
