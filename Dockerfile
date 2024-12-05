FROM maven AS builder
WORKDIR /app

COPY . .


RUN mvn javadoc:javadoc

RUN mvn clean package -DskipTests

FROM eclipse-temurin

WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]