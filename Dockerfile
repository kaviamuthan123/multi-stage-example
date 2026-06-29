FROM eclipse-temurin:8-jdk-alpine AS builder

WORKDIR /app/source

COPY . .

RUN chmod +x mvnw
RUN ./mvnw clean package -DskipTests

FROM eclipse-temurin:8-jre-alpine

WORKDIR /app

COPY --from=builder /app/source/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]
