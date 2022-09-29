FROM tomact

EXPOSE 8080
# java
#ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# Define default command.
CMD ["bash"]

WORKDIR /usr/local/tomcat/webapps

COPY target/*.war /usr/local/tomcat/webapps/dockeransible.war

CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
