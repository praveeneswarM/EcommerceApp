FROM maven:3.9-eclipse-temurin-17 as praveen
WORKDIR /app
COPY . .
RUN mvn clean install -DskipTests

FROM tomcat:9.0-jdk17-temurin
WORKDIR /usr/local/tomcat/webapps/

COPY --from=praveen /app/target/*.war .

EXPOSE 8080
# CMD ["java","-war","target/EcommerceApp.war"]