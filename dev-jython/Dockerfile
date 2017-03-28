FROM tylern4/dev-clara:latest

RUN rm -f /usr/local/bin/pip*
RUN apt-get install -y curl default-jdk
ENV JYTHON_VERSION 2.7.0
RUN curl -Lo jython-installer-${JYTHON_VERSION}.jar\
 "http://search.maven.org/remotecontent?filepath=org/python/jython-installer/${JYTHON_VERSION}/jython-installer-${JYTHON_VERSION}.jar"\
 && java -jar jython-installer-${JYTHON_VERSION}.jar -s -t minimum -i mod -i ensurepip -d /usr/local/jython-${JYTHON_VERSION}\
 &&  rm -f jython-installer-${JYTHON_VERSION}.jar\
 && ln -s /usr/local/jython-${JYTHON_VERSION}/bin/* /usr/local/bin/


WORKDIR /root/

EXPOSE 22
ENTRYPOINT ["/bin/zsh"]
