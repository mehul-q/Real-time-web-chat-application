
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn -B package

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/classes ./target/classes
COPY --from=build /root/.m2 /root/.m2
EXPOSE 8080 8081
CMD ["sh", "-c", "java -cp target/classes WebFiles & java -cp target/classes WebGateway & java -cp target/classes ChatServer"]

