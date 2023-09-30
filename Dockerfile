#FROM eclipse-temurin:17-jdk
#COPY .mvn .mvn
#COPY mvnw .
#COPY pom.xml .
#COPY src /src
#RUN ./mvnw -B package
#EXPOSE 8080
#ENTRYPOINT ["java","-jar","target/simple-app-0.0.1-SNAPSHOT.jar"]

#FROM eclipse-temurin:17-jdk-alpine
#COPY .mvn .mvn
#COPY mvnw .
#COPY pom.xml .
#COPY src /src
#RUN ./mvnw -B package
#EXPOSE 8080
#ENTRYPOINT ["java","-jar","target/simple-app-0.0.1-SNAPSHOT.jar"]

FROM maven:3.8.5-openjdk-17 AS builder
COPY pom.xml /tmp/
COPY src /tmp/src
WORKDIR /tmp
RUN mvn clean package -Dmaven.test.skip

FROM eclipse-temurin:17-jre-alpine
COPY --from=builder /tmp/target/simple-app-0.0.1-SNAPSHOT.jar /tmp/app.jar
WORKDIR /tmp
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]