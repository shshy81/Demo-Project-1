FROM maven:3.5-jdk-8-slim AS build
WORKDIR /home/app
COPY src     /home/app/src
COPY pom.xml /home/app
RUN mvn clean package

FROM openjdk:8-jre-slim
COPY --from=build /home/app/target/hello-spring-1.0.0.jar /usr/local/tomcat/webapps/demo-spring.jar
EXPOSE 8081
ENTRYPOINT ["java","-jar","/usr/local/tomcat/webapps/demo-spring.jar"]


# Start with a base image containing Java runtime
#FROM java:8

# Add Author info
#LABEL maintainer="kulc78@gmail.com"

# Add a volume to /tmp
#VOLUME /tmp

# Make port 8080 available to the world outside this container
#EXPOSE 8080

# The application's jar file
#ARG JAR_FILE=target/hello-spring-1.0.0.jar

# Add the application's jar to the container
#ADD /workspace/target/hello-spring-1.0.0.jar /usr/local/tomcat/webapps/demo-spring.jar

# Run the jar file
#RUN sh -c 'touch /usr/local/tomcat/webapps/demo-spring.jar'
#ENTRYPOINT [ "sh", "-c", "java -Djava.security.egd=file:/dev/./urandom -jar /usr/local/tomcat/webapps/demo-spring.jar" ]