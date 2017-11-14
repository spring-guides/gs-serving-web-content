FROM openjdk
MAINTAINER Piotr Minkowski <piotr.minkowski@gmail.com>
ADD complete/target/gs-serving-web-content-*.jar gs-serving-web-content.jar
ENTRYPOINT ["java", "-jar", "/gs-serving-web-content.jar"]
EXPOSE 8181
