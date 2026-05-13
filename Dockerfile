# Stage 1: Build the JAR using Maven
FROM maven:3.8.5-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml /app
COPY src /app/src
RUN mvn clean package -DskipTests

# Stage 2: Create lightweight runtime image
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /spring-petclinic
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
