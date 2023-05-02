FROM openjdk:8-jdk-alpine
WORKDIR /app
COPY ./target/*.jar /app.jar
COPY ./target/*.jar /app/app.jar
CMD ["java", "-jar", "app.jar"]
