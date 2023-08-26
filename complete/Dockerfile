FROM ubuntu:latest

# Update packages and install necessary tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Download and install OpenJDK 17
RUN curl -L -O "https://download.java.net/java/GA/jdk17/0d483333a00540d886896bac774ff48b/35/GPL/openjdk-17_linux-x64_bin.tar.gz" \
    && tar -xvf openjdk-17_linux-x64_bin.tar.gz -C /opt/ \
    && rm openjdk-17_linux-x64_bin.tar.gz

# Set JAVA_HOME and add Java binaries to PATH
ENV JAVA_HOME="/opt/jdk-17"
ENV PATH="$JAVA_HOME/bin:$PATH"

RUN apt-get update -y && \
apt-get install default-jre -y

ADD ./target/serving-web-content-complete-0.0.1-SNAPSHOT.jar spring-mvc-example.jar

EXPOSE 8080

CMD java -jar spring-mvc-example.jar
