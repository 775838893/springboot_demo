FROM openjdk:11-jre-slim-buster
ARG JAR_FILE
COPY ${JAR_FILE} app.jar
EXPOSE 8008
ENTRYPOINT ["java","-jar","/app.jar"]
