FROM openjdk:17-jdk-alpine as builder
RUN mkdir -p /app/source
COPY .  /app/source
WORKDIR /app/source
RUN ./mvnw clean package

FROM openjdk:17-jdk-alpine as runtime
COPY --from=builder /app/source/target/*.jar spring-mvc-example.jar
EXPOSE 8080
CMD java -jar spring-mvc-example.jar