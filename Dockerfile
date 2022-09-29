FROM tomcat:10
# Take the war and copy to webapps of tomcat
COPY target/*.war /usr/local/tomcat/webapps/dockeransible.war

EXPOSE 8080
# java
#ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# Define default command.
CMD ["bash"]

WORKDIR /usr/local/tomcat/webapps

CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
