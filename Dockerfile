#Stage 1: Building stage
FROM eclipse-temurin:21-jdk-jammy as builder
WORKDIR /workspace
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN ./mvnw dependency:go-offline 
COPY src ./src
RUN ./mvnw package -DskipTests

#Stage 2: Running stage
FROM eclipse-temurin:21-jre-jammy
WORKDIR /app
COPy --from=builder/workspace/target/*.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]
