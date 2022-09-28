FROM centos:7

# Install prerequisites
#RUN apt-get -y update && apt-get -y upgrade
RUN yum install curl java-1.8.0-openjdk wget
RUN mkdir /usr/local/tomcat
RUN wget https://downloads.apache.org/tomcat/tomcat-10/v10.0.20/bin/apache-tomcat-10.0.20.tar.gz -O /tmp/tomcat.tar.gz
RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-10.0.20/* /usr/local/tomcat/

EXPOSE 8080
# java
#ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# Define default command.
CMD ["bash"]


WORKDIR /usr/local/tomcat/webapps
RUN curl -O -L https://github.com/bhaskarndas/sample-war/raw/main/sampletest.war

CMD ["https://net.cloudinfrastructureservices.co.uk/usr/local/tomcat/bin/catalina.sh", "run"]
