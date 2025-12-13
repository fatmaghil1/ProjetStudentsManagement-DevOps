FROM eclipse-temurin:11-jdk-alpine

LABEL maintainer="fatma.ghiloufi@esprit.tn"
LABEL description="Students Management Application - DevOps Project"

WORKDIR /app

COPY target/*.jar app.jar

EXPOSE 8081

ENTRYPOINT ["java", "-jar", "app.jar"]
