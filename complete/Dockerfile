# Pull base image.
FROM ubuntu:latest

RUN \
# Update
apt-get update -y && \
# Install Java
apt-get install default-jre -y

ADD ./target/gs-serving-web-content-0.1.0.jar spring-mvc-example.jar

EXPOSE 8080

CMD java -jar spring-mvc-example.jar
