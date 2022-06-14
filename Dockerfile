FROM openjdk:11
ARG JAR_FILE
COPY ${JAR_FILE} cloud-zuul.jar
EXPOSE 8008
ENTRYPOINT ["java","-jar","springboot_demo.jar"]
