FROM tomcat:8
# Take the war and copy to webapps of tomcatnew
COPY target/*.war /usr/local/tomcat/webapps/dockeransible.war
