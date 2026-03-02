FROM eclipse-temurin
WORKDIR /app
COPY . .
RUN mvn clean install -DskipTests

COPY /app/target/*.jar /app
EXPOSE 8080
CMD ["java","-jar","EcommerceApp.jar"]