FROM centos:7

# Install prerequisites
#RUN apt-get -y update && apt-get -y upgrade
RUN yum -y install curl java-1.8.0-openjdk wget
RUN mkdir /usr/local/tomcat
RUN wget https://downloads.apache.org/tomcat/tomcat-10/v10.0.26/bin/apache-tomcat-10.0.26.tar.gz -O /tmp/tomcat.tar.gz
RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-10.0.26/* /usr/local/tomcat/

EXPOSE 8080
# java
#ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# Define default command.
CMD ["bash"]

WORKDIR /usr/local/tomcat/webapps

COPY target/*.war /usr/local/tomcat/webapps/dockeransible.war

CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
