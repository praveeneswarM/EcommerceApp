FROM maven:3.9-eclipse-temurin-17
WORKDIR /app
COPY . .
RUN mvn clean install -DskipTests

COPY /app/target/*.jar /app
EXPOSE 8080
CMD ["java","-jar","EcommerceApp.jar"]